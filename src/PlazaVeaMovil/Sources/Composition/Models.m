#import <limits.h>
#import <math.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/Constants.h"
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
    NSAttributeDescription *initial =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [initial setName:kFoodInitial];
    [initial setAttributeType:NSStringAttributeType];
    [initial setOptional:NO];
    [initial setIndexed:YES];
    
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
    
    NSAttributeDescription *properties =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [properties setName:kFoodProperties];
    [properties setAttributeType:NSStringAttributeType];
    [properties setOptional:NO];
    [properties setIndexed:YES];
    
    NSAttributeDescription *quantity =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [quantity setName:kFoodQuantity];
    [quantity setAttributeType:NSStringAttributeType];
    [quantity setOptional:NO];
    [quantity setIndexed:YES];
    
    NSAttributeDescription *fiber =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [fiber setName:kFoodFiber];
    [fiber setAttributeType:NSStringAttributeType];
    [fiber setOptional:NO];
    [fiber setIndexed:YES];
    
    NSAttributeDescription *calcium =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [calcium setName:kFoodCalcium];
    [calcium setAttributeType:NSStringAttributeType];
    [calcium setOptional:NO];
    [calcium setIndexed:YES];
    
    NSAttributeDescription *iron =
            [[[NSAttributeDescription alloc] init] autorelease];
    
    [iron setName:kFoodIron];
    [iron setAttributeType:NSStringAttributeType];
    [iron setOptional:NO];
    [iron setIndexed:YES];
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:initial, name, calories, carbohidrates,
                fat, proteins, vitaminA, vitaminC, properties, quantity,
                fiber, calcium, iron, nil]];
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
@dynamic initial, name, calories, carbohidrates, fat, proteins, vitaminA,
        vitaminC, category, properties, quantity, fiber, calcium, iron;

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
          calories:(NSString *)calories 
     carbohidrates:(NSString *)carbohidrates
               fat:(NSString *)fat
          proteins:(NSString *)proteins
          vitaminA:(NSString *)vitaminA
          vitaminC:(NSString *)vitaminC
        properties:(NSString *)properties
           context:(NSManagedObjectContext *)context
{
    Food *food = [[[self alloc] initWithEntity:[self entity]
                insertIntoManagedObjectContext:context] autorelease];
    
    [food setInitial:[name substringToIndex:1]];
    [food setName:name];
    [food setCategory:category];
    [food setCalories:calories];
    [food setCarbohidrates:carbohidrates];
    [food setFat:fat];
    [food setProteins:proteins];
    [food setVitaminA:vitaminA];
    [food setVitaminC:vitaminC];
    [food setProperties:properties];
    return food;
}

+(id)foodWithName:(NSString *)name 
         category:(FoodCategory *)category
         calories:(NSString *)calories
    carbohidrates:(NSString *)carbohidrates
              fat:(NSString *)fat
         proteins:(NSString *)proteins
         vitaminA:(NSString *)vitaminA
         vitaminC:(NSString *)vitaminC
       properties:(NSString *)properties
         quantity:(NSString *)quantity
            fiber:(NSString *)fiber
          calcium:(NSString *)calcium
             iron:(NSString *)iron
          context:(NSManagedObjectContext *)context
{
    Food *food = [[[self alloc] initWithEntity:[self entity]
            insertIntoManagedObjectContext:context] autorelease];
    
    [food setInitial:[name substringToIndex:1]];
    [food setName:name];
    [food setCategory:category];
    [food setCalories:calories];
    [food setCarbohidrates:carbohidrates];
    [food setFat:fat];
    [food setProteins:proteins];
    [food setVitaminA:vitaminA];
    [food setVitaminC:vitaminC];
    [food setProperties:properties];
    [food setQuantity:quantity];
    [food setFiber:fiber];
    [food setCalcium:calcium];
    [food setIron:iron];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kCoreDataDidBegin
            object:self];
    
    BOOL firstUpdate = NO;
    NSArray *csvPathFiles = [[NSBundle mainBundle]
            pathsForResourcesOfType:@"csv" inDirectory:nil];
    
    if ([csvPathFiles count] == 0) {
        return;
    }
    NSString *csvFilePath = [csvPathFiles objectAtIndex:1];
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
    
    if ([[resultsController fetchedObjects] count] == 0) {
        foodFile = [FoodFile fileWithName:csvFilePath context:context];
        firstUpdate = YES;
        [context save:nil];
    } else {
        foodFile = [[resultsController fetchedObjects] objectAtIndex:0];
    }
    if (![[foodFile name] isEqualToString:csvFilePath]) {
        [foodFile setName:csvFilePath];
    } else if(!firstUpdate) {
        [[NSNotificationCenter defaultCenter]
                postNotificationName:kCoreDataDidEnd object:self];
        return;
    }
    
    //deleting old data
    [self cleandata:context];
    
    NSString *csvString = [NSString stringWithContentsOfFile:csvFilePath
            encoding:NSUTF8StringEncoding error:nil];
    NSArray *pasredCSV = [csvString getParsedRows];
    NSMutableDictionary *foodThree = [NSMutableDictionary dictionary];
    NSString *parsedProperties = @"";
    
    for (NSArray *parsedRow in pasredCSV) {
        NSString *parsedRowCategory = [parsedRow objectAtIndex:0];
        NSString *parsedName = [parsedRow objectAtIndex:1];
        NSString *parsedCalories = [parsedRow objectAtIndex:3];
        if (fabs([parsedCalories floatValue]) < (.0 + FLT_EPSILON)) {
            parsedCalories = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailCalories];
        }
        NSString *parsedCarbohidrates = [parsedRow objectAtIndex:6];
        if (fabs([parsedCarbohidrates floatValue]) < (.0 + FLT_EPSILON)) {
            parsedCarbohidrates = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailCarbohidrates];
        }
        NSString *parsedFat = [parsedRow objectAtIndex:5];
        if (fabs([parsedFat floatValue]) < (.0 + FLT_EPSILON)) {
            parsedFat = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailFat];
        }
        NSString *parsedProteins = [parsedRow objectAtIndex:4];
        if (fabs([parsedProteins floatValue]) < (.0 + FLT_EPSILON)) {
            parsedProteins = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailProteins];
        }
        NSString *parsedVitaminA = [parsedRow objectAtIndex:10];
        if (fabs([parsedVitaminA doubleValue]) < (.0 + FLT_EPSILON)) {
            parsedVitaminA = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailVitaminA];
        }
        NSString *parsedVitaminC = [parsedRow objectAtIndex:11];
        if (fabs([parsedVitaminC floatValue]) < (.0 + FLT_EPSILON)) {
            parsedVitaminC = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailVitaminC];
        }
        NSString *parsedQuantity = [parsedRow objectAtIndex:2];
        if (fabs([parsedQuantity floatValue]) < (.0 + FLT_EPSILON)) {
            parsedQuantity = @"";
        /*} else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailVitaminC];*/
        }
        NSString *parsedFiber = [parsedRow objectAtIndex:7];
        if (fabs([parsedFiber floatValue]) < (.0 + FLT_EPSILON)) {
            parsedFiber = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailFiber];
        }
        NSString *parsedCalcium = [parsedRow objectAtIndex:8];
        if (fabs([parsedCalcium floatValue]) < (.0 + FLT_EPSILON)) {
            parsedCalcium = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailCalcium];
        }
        NSString *parsedIron = [parsedRow objectAtIndex:9];
        if (fabs([parsedIron floatValue]) < (.0 + FLT_EPSILON)) {
            parsedIron = @"";
        } else {
            parsedProperties = [parsedProperties
                    stringByAppendingString:kFoodDetailIron];
        }
        
        NSMutableArray *parsedCollectionFoods =
                [foodThree objectForKey:parsedRowCategory];
        
        if (parsedCollectionFoods == nil) {
            parsedCollectionFoods = [NSMutableArray array];
            [foodThree setObject: parsedCollectionFoods
                    forKey:parsedRowCategory];
        }
        [parsedCollectionFoods addObject:
                [NSDictionary dictionaryWithObjectsAndKeys:
                    parsedName, kFoodName,
                    parsedCalories, kFoodCalories,
                    parsedCarbohidrates, kFoodCarbohidrates,
                    parsedFat, kFoodFat,
                    parsedProteins, kFoodProteins,
                    parsedVitaminA, kFoodVitaminA,
                    parsedVitaminC, kFoodVitaminC,
                    parsedProperties, kFoodProperties,
                    parsedQuantity, kFoodQuantity,
                    parsedFiber, kFoodFiber,
                    parsedCalcium, kFoodCalcium,
                    parsedIron, kFoodIron,
                    nil]];
    }
    for (NSString *categoryname in [foodThree allKeys]) {
        FoodCategory *foodCategory =
                [FoodCategory categoryWithName:categoryname context:context];
        NSArray *foodCollection = [foodThree objectForKey:categoryname];
        
        for (NSDictionary *food in foodCollection) {
            NSString *name = [food objectForKey:kFoodName];
            NSString *calories = [food objectForKey:kFoodCalories];
            NSString *carbohidrates = [food objectForKey:kFoodCarbohidrates];
            NSString *fat = [food objectForKey:kFoodFat];
            NSString *proteins = [food objectForKey:kFoodProteins];
            NSString *vitaminA = [food objectForKey:kFoodVitaminA];
            NSString *vitaminC = [food objectForKey:kFoodVitaminC];
            NSString *properties = [food objectForKey:kFoodProperties];
            NSString *quantity = [food objectForKey:kFoodQuantity];
            NSString *fiber = [food objectForKey:kFoodFiber];
            NSString *calcium = [food objectForKey:kFoodCalcium];
            NSString *iron = [food objectForKey:kFoodIron];
            /*[Food foodWithName:name category:foodCategory calories:calories
                    carbohidrates:carbohidrates fat:fat proteins:proteins
                        vitaminA:vitaminA vitaminC:vitaminC
                        properties:properties context:context];*/
            [Food foodWithName:name
                      category:foodCategory
                      calories:calories
                 carbohidrates:carbohidrates
                           fat:fat
                      proteins:proteins
                      vitaminA:vitaminA
                      vitaminC:vitaminC
                    properties:properties
                      quantity:quantity
                         fiber:fiber
                       calcium:calcium
                          iron:iron
                       context:context];
        }
    }
    [context save:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCoreDataDidEnd
            object:self];
}

+ (void)cleandata:(NSManagedObjectContext *)context
{
    //category
    NSArray *sortCategoryDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kFoodCategoryName
                    ascending:YES] autorelease]];
    NSFetchRequest *categoryRequest =
    [[[NSFetchRequest alloc] init] autorelease];
    
    [categoryRequest setEntity:[FoodCategory entity]];
    [categoryRequest setPredicate:nil];
    [categoryRequest setSortDescriptors:sortCategoryDescriptors];
    
    NSFetchedResultsController *resultsController =
            [[[NSFetchedResultsController alloc] initWithFetchRequest:
                categoryRequest managedObjectContext:context sectionNameKeyPath:
                nil cacheName:nil] autorelease];
    NSError *fetchError = nil;
    
    [resultsController performFetch:&fetchError];
    for (NSManagedObject *manageObject in [resultsController fetchedObjects]) {
        [context deleteObject:manageObject];
    }
    [context save:nil];
    // foods
    NSArray *sortNumberDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kFoodName
                ascending:YES] autorelease]];
    NSFetchRequest *foodRequest = [[[NSFetchRequest alloc] init] autorelease];
    
    [foodRequest setEntity:[Food entity]];
    [foodRequest setPredicate:nil];
    [foodRequest setSortDescriptors:sortNumberDescriptors];
    
    resultsController = [[[NSFetchedResultsController alloc]
            initWithFetchRequest:foodRequest managedObjectContext:context
                sectionNameKeyPath:nil cacheName:nil] autorelease];
    fetchError = nil;
    
    [resultsController performFetch:&fetchError];
    for (NSManagedObject *manageObject in [resultsController fetchedObjects]) {
        [context deleteObject:manageObject];
    }
    [context save:nil];
}
@end