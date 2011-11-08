#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"

static NSRelationshipDescription *kNumbersRelationship;
static NSRelationshipDescription *kCategoryRelationship;

@implementation EmergencyCategory

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kEmergencyCategoryName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObject:name];
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *numbersRelationship =
            [self relationshipWithName:kEmergencyCategoryNumbers];

    [numbersRelationship setName:kEmergencyCategoryNumbers];
    [numbersRelationship setDestinationEntity:[EmergencyNumber entity]];
    [numbersRelationship setInverseRelationship:
            [EmergencyNumber relationshipWithName:kEmergencyNumberCategory]];
    [numbersRelationship setOptional:NO];
    [numbersRelationship setMaxCount:-1]; // infinite to-many relationship
    [numbersRelationship setMinCount:0];
    [numbersRelationship setDeleteRule:NSCascadeDeleteRule];
    return [relationships setByAddingObject:numbersRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)name
{
    NSRelationshipDescription *relationship = [super relationshipWithName:name];

    if (relationship != nil)
        return relationship;
    if ([name isEqualToString:kEmergencyCategoryNumbers]) {
        if (kNumbersRelationship == nil)
            kNumbersRelationship = [[NSRelationshipDescription alloc] init];
        return kNumbersRelationship;
    }
    return nil;
}

#pragma mark -
#pragma mark EmergencyCategory (Public)

// KVO properties
@dynamic name, numbers;

+ (id)categoryWithName:(NSString *)name
               context:(NSManagedObjectContext *)context
{
    EmergencyCategory *category = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];

    [category setName:name];
    return category;
}

+ (id)categoryWithName:(NSString *)name
     resultsController:(NSFetchedResultsController *)resultsController
{
    EmergencyCategory *category = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:
                [resultsController managedObjectContext]] autorelease];

    [category setName:name];
    return category;
}
@end

@implementation EmergencyNumber

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kEmergencyNumberName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting

    NSAttributeDescription *phone =
            [[[NSAttributeDescription alloc] init] autorelease];

    [phone setName:kEmergencyNumberPhone];
    [phone setAttributeType:NSStringAttributeType];
    [phone setOptional:NO];
    [phone setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, phone, nil]];

}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *categoryRelationship =
            [self relationshipWithName:kEmergencyNumberCategory];

    [categoryRelationship setName:kEmergencyNumberCategory];
    [categoryRelationship setDestinationEntity:[EmergencyNumber entity]];
    [categoryRelationship setInverseRelationship:
            [EmergencyCategory relationshipWithName:kEmergencyCategoryNumbers]];
    [categoryRelationship setOptional:NO];
    [categoryRelationship setMaxCount:1]; // to-one relationship
    [categoryRelationship setMinCount:1];
    [categoryRelationship setDeleteRule:NSNullifyDeleteRule];
    return [relationships setByAddingObject:categoryRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)name
{
    NSRelationshipDescription *relationship = [super relationshipWithName:name];

    if (relationship != nil)
        return relationship;
    if ([name isEqualToString:kEmergencyNumberCategory]) {
        if (kCategoryRelationship == nil)
            kCategoryRelationship = [[NSRelationshipDescription alloc] init];
        return kCategoryRelationship;
    }
    return nil;
}

#pragma mark -
#pragma mark EmergencyNumber (Public)

// KVO properties
@dynamic name, phone, category;

+ (id)numberWithName:(NSString *)name
               phone:(NSString *)phone
            category:(EmergencyCategory *)category
             context:(NSManagedObjectContext *)context
{
    EmergencyNumber *number = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];

    [number setName:name];
    [number setPhone:phone];
    [number setCategory:category];
    return category;
}

+ (id)numberWithName:(NSString *)name
               phone:(NSString *)phone
            category:(EmergencyCategory *)category
   resultsController:(NSFetchedResultsController *)resultsController
{
    EmergencyNumber *number = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:
                [resultsController managedObjectContext]] autorelease];

    [number setName:name];
    [number setPhone:phone];
    [number setCategory:category];
    return category;
}
@end

@implementation EmergencyFile

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kEmergencyFileName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, nil]];

}

#pragma mark -
#pragma mark EmergencyFile (Public)

// KVO properties
@dynamic name;

+ (id)fileWithName:(NSString *)name
             context:(NSManagedObjectContext *)context
{
    EmergencyFile *file = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];

    [file setName:name];
    return file;
}

+ (id)fileWithName:(NSString *)name
   resultsController:(NSFetchedResultsController *)resultsController
{
    EmergencyFile *file = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:
                [resultsController managedObjectContext]] autorelease];

    [file setName:name];
    return file;
}

+ (void)loadFromCSVinContext:(NSManagedObjectContext *)context
{
    BOOL firstUpdate = NO;
    NSArray *csvPathFiles = [[NSBundle mainBundle]
            pathsForResourcesOfType:@"csv" inDirectory:nil];

    if ([csvPathFiles count] == 0){
        return;
    }

    NSString *csvFilePath = [csvPathFiles objectAtIndex:0];
    NSArray *sortFileNameDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyFileName
                ascending:YES] autorelease]];
    NSFetchRequest *fileRequest = [[[NSFetchRequest alloc] init] autorelease];

    [fileRequest setEntity:[EmergencyFile entity]];
    [fileRequest setPredicate:nil];
    [fileRequest setSortDescriptors:sortFileNameDescriptors];

    NSFetchedResultsController *resultsController = 
        [[[NSFetchedResultsController alloc]
            initWithFetchRequest:fileRequest
            managedObjectContext:context
            sectionNameKeyPath:nil
            cacheName:nil] autorelease];
    NSError *fetchError = nil;
    NSError *contextError = nil;

    [resultsController performFetch:&fetchError];
    if ([[resultsController fetchedObjects] count] == 0){
        [EmergencyFile fileWithName:csvFilePath context:context];
        firstUpdate = YES;
        [context save:&contextError];
        [resultsController performFetch:&fetchError];
    }

    EmergencyFile *emergencyFile = [[resultsController fetchedObjects]
        objectAtIndex:0];

    if (![[emergencyFile name] isEqualToString:csvFilePath]){
        [emergencyFile setName:csvFilePath];
    } else if(!firstUpdate) {
        return;
    }

    NSString *csvString = [NSString stringWithContentsOfFile:csvFilePath
            encoding:NSUTF8StringEncoding error:nil];
    NSArray *pasredCSV = [csvString getParsedRows];
    NSMutableDictionary *emergencyThree = [NSMutableDictionary dictionary];

    for (NSArray *parsedRow in pasredCSV){
        NSString *parsedRowCategory = [parsedRow objectAtIndex:0];
        NSMutableArray *parsedCollectionNumbers = [emergencyThree 
                objectForKey:parsedRowCategory];

        if (parsedCollectionNumbers == nil){
            [emergencyThree setObject:[NSMutableArray array] 
                    forKey:parsedRowCategory];
        }
        NSString *parsedName = [parsedRow objectAtIndex:1];
        NSString *parsedNumber = [parsedRow objectAtIndex:2];
        [parsedCollectionNumbers addObject:[NSDictionary 
                dictionaryWithObjectsAndKeys:parsedName, @"name", parsedNumber,
                @"number", nil]];
    }
    //TODO: delete all entries
    //TODO: store all data
    NSLog(@"%@", emergencyThree);

}
@end
