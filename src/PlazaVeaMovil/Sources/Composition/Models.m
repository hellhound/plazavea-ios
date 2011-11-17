#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Composition/Constants.h"
#import "Composition/Models.h"

static NSRelationshipDescription *kFoodsRelationship;
static NSRelationshipDescription *kCategoryRelationship;

@implementation FoodCategory

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [name setName:kFoodCategoryName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObject:name];
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *foodsRelationship =
            [self relationshipWithName:kFoodCategoryFoods];
    
    [foodsRelationship setName:kFoodCategoryFoods];
    [foodsRelationship setDestinationEntity:[Food entity]];
    [foodsRelationship setInverseRelationship:
            [Food relationshipWithName:kFoodCategory]];
    [foodsRelationship setOptional:NO];
    [foodsRelationship setMaxCount:-1]; // infinite to-many relationship
    [foodsRelationship setMinCount:0];
    [foodsRelationship setDeleteRule:NSCascadeDeleteRule];
    return [relationships setByAddingObject:foodsRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)name
{
    NSRelationshipDescription *relationship = [super relationshipWithName:name];
    
    if (relationship != nil)
        return relationship;
    if ([name isEqualToString:kFoodCategoryFoods]) {
        if (kFoodsRelationship == nil)
            kFoodsRelationship = [[NSRelationshipDescription alloc] init];
        return kFoodsRelationship;
    }
    return nil;
}

#pragma mark -
#pragma mark FoodCategory (Public)

// KVO properties
@dynamic name, foods;

+ (id)categoryWithName:(NSString *)name
               context:(NSManagedObjectContext *)context
{
    FoodCategory *category = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];
    
    [category setName:name];
    return category;
}

+ (id)categoryWithName:(NSString *)name
     resultsController:(NSFetchedResultsController *)resultsController
{
    FoodCategory *category = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:
                [resultsController managedObjectContext]] autorelease];
    
    [category setName:name];
    return category;
}
@end

@implementation Food

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [name setName:kFoodName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *calories =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [calories setName:kFoodCalories];
    [calories setAttributeType:NSStringAttributeType];
    [calories setOptional:NO];
    [calories setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *carbohidrates =
    [[[NSAttributeDescription alloc] init] autorelease];
    
    [carbohidrates setName:kFoodCarbohidrates];
    [carbohidrates setAttributeType:NSStringAttributeType];
    [carbohidrates setOptional:NO];
    [carbohidrates setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *fat =
    [[[NSAttributeDescription alloc] init] autorelease];
    
    [fat setName:kFoodFat];
    [fat setAttributeType:NSStringAttributeType];
    [fat setOptional:NO];
    [fat setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *proteins =
    [[[NSAttributeDescription alloc] init] autorelease];
    
    [proteins setName:kFoodProteins];
    [proteins setAttributeType:NSStringAttributeType];
    [proteins setOptional:NO];
    [proteins setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *vitaminA =
    [[[NSAttributeDescription alloc] init] autorelease];
    
    [vitaminA setName:kFoodVitaminA];
    [vitaminA setAttributeType:NSStringAttributeType];
    [vitaminA setOptional:NO];
    [vitaminA setIndexed:YES]; // allows faster searching and sorting
    
    NSAttributeDescription *vitaminC =
    [[[NSAttributeDescription alloc] init] autorelease];
    
    [vitaminC setName:kFoodVitaminC];
    [vitaminC setAttributeType:NSStringAttributeType];
    [vitaminC setOptional:NO];
    [vitaminC setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, calories, carbohidrates, fat, proteins,
                vitaminA, vitaminC, nil]];
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *foodRelationship =
            [self relationshipWithName:kFoodCategory];
    
    [foodRelationship setName:kFoodCategory];
    [foodRelationship setDestinationEntity:[FoodCategory entity]];
    [foodRelationship setInverseRelationship:
            [FoodCategory relationshipWithName:kFoodCategoryFoods]];
    [foodRelationship setOptional:NO];
    [foodRelationship setMaxCount:1]; // to-one relationship
    [foodRelationship setMinCount:1];
    [foodRelationship setDeleteRule:NSNullifyDeleteRule];
    return [relationships setByAddingObject:foodRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)name
{
    NSRelationshipDescription *relationship = [super relationshipWithName:name];
    
    if (relationship != nil)
        return relationship;
    if ([name isEqualToString:kFoodCategory]) {
        if (kCategoryRelationship == nil)
            kCategoryRelationship = [[NSRelationshipDescription alloc] init];
        return kCategoryRelationship;
    }
    return nil;
}

#pragma mark -
#pragma mark Food (Public)

// KVO properties
@dynamic name, calories, carbohidates, fat, proteins, vitaminA, vitaminC,
        category;

+ (id)foodWithName:(NSString *)name
            category:(FoodCategory *)category
             context:(NSManagedObjectContext *)context
{
    Food *food = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];
    
    [food setName:name];
    [food setCategory:category];
    return food;
}

+ (id)foodWithName:(NSString *)name
            category:(FoodCategory *)category
   resultsController:(NSFetchedResultsController *)resultsController
{
    Food *food = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:
                [resultsController managedObjectContext]] autorelease];
    
    [food setName:name];
    [food setCategory:category];
    return food;
}
@end

@implementation FoodFile

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [name setName:kFoodFileName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];
    [name setIndexed:YES]; // allows faster searching and sorting
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, nil]];
}

#pragma mark -
#pragma mark FoodFile (Public)

// KVO properties
@dynamic name;

+ (id)fileWithName:(NSString *)name
           context:(NSManagedObjectContext *)context
{
    FoodFile *file = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];
    
    [file setName:name];
    return file;
}

+ (id)fileWithName:(NSString *)name
 resultsController:(NSFetchedResultsController *)resultsController
{
    FoodFile *file = [[[self alloc] initWithEntity:[self entity]
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
            [[[NSSortDescriptor alloc] initWithKey:kFoodFileName
                ascending:YES] autorelease]];
    NSFetchRequest *fileRequest = [[[NSFetchRequest alloc] init] autorelease];
    
    [fileRequest setEntity:[FoodFile entity]];
    [fileRequest setPredicate:nil];
    [fileRequest setSortDescriptors:sortFileNameDescriptors];
    
    NSFetchedResultsController *resultsController = 
            [[[NSFetchedResultsController alloc] initWithFetchRequest:
                fileRequest managedObjectContext:context sectionNameKeyPath:nil
                cacheName:nil] autorelease];
    NSError *fetchError = nil;
    
    [resultsController performFetch:&fetchError];
    
    FoodFile *foodFile;
    
    if ([[resultsController fetchedObjects] count] == 0){
        foodFile = [FoodFile fileWithName:csvFilePath context:context];
        firstUpdate = YES;
        [context save:nil];
    } else {
        foodFile = [[resultsController fetchedObjects] objectAtIndex:0];
    }
    if (![[foodFile name] isEqualToString:csvFilePath]){
        [foodFile setName:csvFilePath];
    } else if(!firstUpdate) {
        return;
    }
    
    //deleting old data
    [self cleandata:context];
    
    NSString *csvString = [NSString stringWithContentsOfFile:csvFilePath
            encoding:NSUTF8StringEncoding error:nil];
    NSArray *pasredCSV = [csvString getParsedRows];
    NSMutableDictionary *foodThree = [NSMutableDictionary dictionary];
    
    for (NSArray *parsedRow in pasredCSV){
        NSString *parsedRowCategory = [parsedRow objectAtIndex:0];
        NSString *parsedName = [parsedRow objectAtIndex:1];
        // food especific rows
        NSMutableArray *parsedCollectionNumbers =
                [foodThree objectForKey:parsedRowCategory];
        
        if (parsedCollectionNumbers == nil){
            parsedCollectionNumbers = [NSMutableArray array];
            [foodThree setObject: parsedCollectionNumbers
                               forKey:parsedRowCategory];
        }
        [parsedCollectionNumbers addObject:[NSDictionary 
                                            dictionaryWithObjectsAndKeys:parsedName, kEmergencyNumberName,
                                            parsedNumber, kEmergencyNumberPhone, nil]];
    }
    for (NSString *categoryname in [foodThree allKeys]){
        EmergencyCategory *emergencyCategory = [EmergencyCategory
                                                categoryWithName:categoryname context:context];
        NSArray *emergencyNumberCollection = [foodThree 
                                              objectForKey:categoryname];
        
        for (NSDictionary *emergencyNumber in emergencyNumberCollection){
            NSString *name =
            [emergencyNumber objectForKey:kEmergencyNumberName];
            NSString *phone =
            [emergencyNumber objectForKey:kEmergencyNumberPhone];
            [EmergencyNumber numberWithName:name phone:phone
                                   category:emergencyCategory context:context];
            [context save:nil];
        }
    }
}
@end