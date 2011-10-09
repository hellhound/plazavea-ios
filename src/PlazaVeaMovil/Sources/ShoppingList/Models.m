#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Models/Constants.h"
#import "Common/Models/ManagedObject.h"
#import "Common/Models/ReorderingManagedObject.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"

static NSRelationshipDescription *kItemsRelationship;
static NSRelationshipDescription *kListRelationship;
// Predicate templates
static NSPredicate *kPreviousListPredicateTemplate;
static NSPredicate *kNextListPredicateTemplate;
static NSPredicate *kHistoryEntryNamePredicateTemplate;
// Sopping lists name
static NSString *const kCloningRepetitionSeparators = @"()";

@interface ShoppingList ()

//@private
@property (nonatomic, retain) NSDate *primitiveLastModificationDate;

+ (void)initializePredicateTemplates;

- (NSPredicate *)predicateForPreviousList;
- (NSPredicate *)predicateForNextList;
@end

@interface ShoppingHistoryEntry (Private)

+ (void)initializePredicateTemplates;
+ (NSPredicate *)predicateForHistoryEntryName:(NSString *)name;
@end

@implementation ShoppingList

#pragma mark -
#pragma mark NSManagedObject

- (void)willSave
{
    if (([self isInserted] || [self isUpdated]) && ![self isDeleted])
        // Using primitives inside willSave avoids infinite recursion
        [self setPrimitiveLastModificationDate:[NSDate date]];
}

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (void)classDidInitialize
{
    [self initializePredicateTemplates];
}

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kShoppingListName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *lastModificationDate =
            [[[NSAttributeDescription alloc] init] autorelease];

    [lastModificationDate setName:kShoppingListLastModificationDate];
    [lastModificationDate setAttributeType:NSDateAttributeType];
    [lastModificationDate setOptional:YES];
    // setting properties into the entity
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, lastModificationDate, nil]]; 
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];

    kItemsRelationship = [self relationshipWithName:kShoppingListItems];
    [kItemsRelationship setName:kShoppingListItems];
    [kItemsRelationship setDestinationEntity:[ShoppingItem entity]];
    [kItemsRelationship setInverseRelationship:
            [ShoppingItem relationshipWithName:kShoppingItemList]];
    [kItemsRelationship setOptional:NO];
    [kItemsRelationship setMaxCount:-1]; // to-many relationship
    [kItemsRelationship setMinCount:0];
    [kItemsRelationship setDeleteRule:NSCascadeDeleteRule];
    return [relationships setByAddingObject:kItemsRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)relationshipName
{
    NSRelationshipDescription *relationship =
            [super relationshipWithName:relationshipName];

    if (relationship != nil)
        return relationship;
    if ([relationshipName isEqualToString:kShoppingListItems]) {
        if (kItemsRelationship == nil)
            kItemsRelationship = [[NSRelationshipDescription alloc] init];
        return kItemsRelationship; 
    }
    return nil;
}

#pragma mark -
#pragma mark ShoppingList (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs = [NSExpression expressionForKeyPath:kOrderField];
    NSExpression *rhs = [NSExpression expressionForVariable:kOrderField];

    kPreviousListPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSLessThanPredicateOperatorType
            options:0] retain];
    kNextListPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSGreaterThanPredicateOperatorType
            options:0] retain];
}

- (NSPredicate *)predicateForPreviousList
{
    return [kPreviousListPredicateTemplate predicateWithSubstitutionVariables:
            [NSDictionary dictionaryWithObject:[self order]
                forKey:kOrderField]];
}

- (NSPredicate *)predicateForNextList
{
    return [kNextListPredicateTemplate predicateWithSubstitutionVariables:
            [NSDictionary dictionaryWithObject:[self order]
                forKey:kOrderField]];
}

#pragma mark -
#pragma mark ShoppingList (Public)

// primitives
@dynamic primitiveLastModificationDate;
// KVO properties
@dynamic name, lastModificationDate, order, items;

+ (id)shoppingListWithName:(NSString *)name
                   context:(NSManagedObjectContext *)context
{
    ShoppingList *newList = [self orderedObjectWithContext:context];

    [newList setName:name];
    return newList;
}

+ (id)shoppingListWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController
{
    ShoppingList *newList =
            [self orderedObjectWithResultsController:resultsController];

    [newList setName:name];
    return newList;
}

+ (NSString *)resolveNewNameFromName:(NSString *)name
                      shouldBeCloned:(BOOL)shouldBeCloned
{
    NSString *constantExpression =
        [NSString stringWithFormat:kShoppingListCloningRepetitionPattern,
            [name stringByEscapingReservedRECharacterSet],
            kShoppingListCloningRepetitionName];
    NSExpression *lhs = [NSExpression expressionForKeyPath:kShoppingListName];
    NSExpression *rhs = [NSExpression expressionForConstantValue:
            NSLocalizedString(constantExpression, nil)];
    NSPredicate *predicate =
            [NSComparisonPredicate predicateWithLeftExpression:lhs
                rightExpression:rhs
                modifier:NSDirectPredicateModifier
                type:NSMatchesPredicateOperatorType
                options:NSCaseInsensitivePredicateOption |
                    NSDiacriticInsensitivePredicateOption];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey:kShoppingListName
                ascending:NO]];
    NSCharacterSet *cloningRepetitionSeparatorsSet =
            [[NSCharacterSet characterSetWithCharactersInString:
                kCloningRepetitionSeparators] retain];

    [request setEntity:[self entity]];
    [request setPredicate:predicate];
    [request setSortDescriptors:sortDescriptors];

    NSArray *filteredLists = [context executeFetchRequest:request];

    if ([filteredLists count] == 0)
        // There's no repeated name, give up an return the original name
        return shouldBeCloned ?
                [NSString stringWithFormat:kShoppingListCloningRepetitionSuffix,
                    name, kShoppingListCloningRepetitionName, 1] : name;

    NSString *candidateName =
            [(ShoppingList *)[filteredLists objectAtIndex:0] name];
    NSArray *tokens = [candidateName componentsSeparatedByCharactersInSet:
            cloningRepetitionSeparatorsSet];

    // Each token will always be an NSString and tokens will always have
    // at least 3 elements
    tokens = [(NSString *)[tokens objectAtIndex:[tokens count] - 2]
            componentsSeparatedByCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSInteger copyNumber = 0;
    NSString *token;
    NSEnumerator *enumerator = [tokens reverseObjectEnumerator];

    while ((token = [enumerator nextObject]) != nil)
        if ((copyNumber = [token integerValue]) > 0)
            break;
    copyNumber++;
    return [NSString stringWithFormat:kShoppingListCloningRepetitionSuffix,
            name, kShoppingListCloningRepetitionName, copyNumber];
}

- (NSString *)formattedLastModiciationDate
{
    return [[(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter]
                stringFromDate:[self lastModificationDate]];
}

- (ShoppingList *)previous
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    // We want the previous list in order, so we sort the resulting fetched
    // array in descending order
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey:kOrderField ascending:NO]];

    [request setEntity:[self entity]];
    [request setPredicate:[self predicateForPreviousList]];
    [request setFetchLimit:1];
    [request setSortDescriptors:sortDescriptors];

    NSArray *lists = [[self managedObjectContext] executeFetchRequest:request];

    if ([lists count] == 0) {
        // Request the last list
        [request setPredicate:[self predicateForNextList]];
        lists = [[self managedObjectContext] executeFetchRequest:request];
        if ([lists count] == 0)
            return nil;
    }
    return [lists objectAtIndex:0];
}

- (ShoppingList *)next
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    // We want the  next list in order, so we sort the resulting fetched
    // array in  ascending order
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey:kOrderField ascending:YES]];

    [request setEntity:[self entity]];
    [request setPredicate:[self predicateForNextList]];
    [request setFetchLimit:1];
    [request setSortDescriptors:sortDescriptors];

    NSArray *lists = [[self managedObjectContext] executeFetchRequest:request];

    if ([lists count] == 0) {
        // Request the first list
        [request setPredicate:[self predicateForPreviousList]];
        lists = [[self managedObjectContext] executeFetchRequest:request];
        if ([lists count] == 0)
            return nil;
    }
    return [lists objectAtIndex:0];
}

- (NSString *)serialize
{
    // Uberness in the making, KVC is _TRULY_ useful
    return [(NSArray *)[[[self items] allObjects] valueForKey:@"serialize"]
            componentsJoinedByString:@"\n"];
}
@end

@implementation ShoppingItem

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kShoppingItemName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *quantity =
            [[[NSAttributeDescription alloc] init] autorelease];

    [quantity setName:kShoppingItemQuantity];
    [quantity setAttributeType:NSStringAttributeType];
    [quantity setOptional:YES];
    [quantity setDefaultValue:@""];

    NSAttributeDescription *checked =
            [[[NSAttributeDescription alloc] init] autorelease];

    [checked setName:kShoppingItemChecked];
    [checked setAttributeType:NSInteger32AttributeType];
    [checked setOptional:NO];
    [checked setDefaultValue:[NSNumber numberWithBool:NO]];
    // setting properties into the entity
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, quantity, checked, nil]]; 
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    kListRelationship = [self relationshipWithName:kShoppingItemList];
    [kListRelationship setName:kShoppingItemList];
    [kListRelationship setDestinationEntity:[ShoppingList entity]];
    [kListRelationship setInverseRelationship:
            [ShoppingList relationshipWithName:kShoppingListItems]];
    [kListRelationship setOptional:NO];
    [kListRelationship setMaxCount:1];
    [kListRelationship setMinCount:1];
    [kListRelationship setDeleteRule:NSNullifyDeleteRule];
    return [relationships setByAddingObject:kListRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)relationshipName
{
    NSRelationshipDescription *relationship =
            [super relationshipWithName:relationshipName];

    if (relationship != nil)
        return relationship;
    if ([relationshipName isEqualToString:kShoppingItemList]) {
        if (kListRelationship == nil)
            kListRelationship = [[NSRelationshipDescription alloc] init];
        return kListRelationship; 
    }
    return nil;
}

#pragma mark -
#pragma mark ShoppingItem (Public)

@dynamic name, quantity, order, checked, list;

+ (id)shoppingItemWithName:(NSString *)name
                  quantity:(NSString *)quantity
                      list:(ShoppingList *)shoppingList
                   context:(NSManagedObjectContext *)context
{
    ShoppingItem *newItem = [self orderedObjectWithContext:context];

    [newItem setName:name];
    [newItem setQuantity:quantity];
    [newItem setList:shoppingList];
    return newItem;
}

+ (id)shoppingItemWithName:(NSString *)name
                  quantity:(NSString *)quantity
                      list:(ShoppingList *)shoppingList
         resultsController:(NSFetchedResultsController *)resultsController
{
    ShoppingItem *newItem =
            [self orderedObjectWithResultsController:resultsController];

    [newItem setName:name];
    [newItem setQuantity:quantity];
    [newItem setList:shoppingList];
    return newItem;
}

- (NSString *)serialize
{
    if ([self quantity] != nil)
        return [NSString stringWithFormat:@"%@ %@", [self quantity],
                [self name]];
    return [self name];
}
@end

@implementation ShoppingHistoryEntry

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (void)classDidInitialize
{
    [self initializePredicateTemplates];
}

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kShoppingHistoryEntryName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES];
    // Setting the properties into the entity
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObject:name]];
}

#pragma mark -
#pragma mark ShoppingHistoryEntry (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs =
            [NSExpression expressionForKeyPath:kShoppingHistoryEntryName];
    NSExpression *rhs =
            [NSExpression expressionForVariable:kShoppingHistoryEntryName];

    kHistoryEntryNamePredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSEqualToPredicateOperatorType
            options:0] retain];
}

+ (NSPredicate *)predicateForHistoryEntryName:(NSString *)name
{
    return [kHistoryEntryNamePredicateTemplate
            predicateWithSubstitutionVariables:
                [NSDictionary dictionaryWithObject:name
                    forKey:kShoppingHistoryEntryName]];
}

#pragma mark -
#pragma mark ShoppingHistoryEntry (Public)

@dynamic name;

+ (id)historyEntryWithName:(NSString *)name
                   context:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

    [request setEntity:[self entity]];

    NSArray *entries = [[context executeFetchRequest:request]
            filteredArrayUsingPredicate:
                [ShoppingHistoryEntry predicateForHistoryEntryName:name]];
    if ([entries count] > 0)
        // We already have it
        return [entries objectAtIndex:0];

    ShoppingHistoryEntry *newHistoryEntry =
            [[[ShoppingHistoryEntry alloc] initWithEntity:[self entity]
                insertIntoManagedObjectContext:context] autorelease];

    [newHistoryEntry setName:name];
    return newHistoryEntry;
}

+ (id)historyEntryWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController
{
    NSArray *entries = [[resultsController fetchedObjects]
            filteredArrayUsingPredicate:
                [ShoppingHistoryEntry predicateForHistoryEntryName:name]];
    
    if ([entries count] > 0)
        // We already have it 
        return [entries objectAtIndex:0];

    ShoppingHistoryEntry *newHistoryEntry =
            [[[ShoppingHistoryEntry alloc] initWithEntity:[self entity]
                insertIntoManagedObjectContext:
                    [resultsController managedObjectContext]] autorelease];

    [newHistoryEntry setName:name];
    return newHistoryEntry;
}
@end
