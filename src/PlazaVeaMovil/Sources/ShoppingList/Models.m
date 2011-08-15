#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"
#import "Common/Models/ReorderingManagedObject.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"

static NSRelationshipDescription *kItemsRelationship;
static NSRelationshipDescription *kListRelationship;

@interface ShoppingList ()

//@private
@property (nonatomic, retain) NSDate *primitiveLastModificationDate;
@end

@implementation ShoppingList

#pragma mark -
#pragma mark NSManagedObject

- (void)willSave
{
    if (![self isDeleted])
        // Using primitives inside willSave avoids infinite recursion
        [self setPrimitiveLastModificationDate:[NSDate date]];
}

#pragma mark -
#pragma mark ManagedObject (Overridable)

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
#pragma mark ShoppingList

// primitives
@dynamic primitiveLastModificationDate;
// KVO properties
@dynamic name, lastModificationDate, order, items;

+ (id)shoppingListWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController
{
    ShoppingList *newList =
            [self orderedObjectWithResultsController:resultsController];

    [newList setName:name];
    return newList;
}

- (NSString *)formattedLastModiciationDate
{
    return [[(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter]
                stringFromDate:[self lastModificationDate]];
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
    [checked setDefaultValue:[NSNumber numberWithInteger:0]];
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
#pragma mark ShoppingItem

@dynamic name, quantity, order, checked, list;
@end

@implementation ShoppingHistoryEntry

#pragma mark -
#pragma mark ManagedObject (Overridable)

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
#pragma mark ShoppingHistoryEntry (Public)

@dynamic name;
@end
