#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"

@interface FoodCategory: ManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *foods;

+ (id)categoryWithName:(NSString *)name
               context:(NSManagedObjectContext *)context;
+ (id)categoryWithName:(NSString *)name
     resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface Food: ManagedObject

@property (nonatomic, retain) NSString *initial;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *calories;
@property (nonatomic, retain) NSString *carbohidrates;
@property (nonatomic, retain) NSString *fat;
@property (nonatomic, retain) NSString *proteins;
@property (nonatomic, retain) NSString *vitaminA;
@property (nonatomic, retain) NSString *vitaminC;
@property (nonatomic, retain) FoodCategory *category;
@property (nonatomic, retain) NSString *properties;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSString *fiber;
@property (nonatomic, retain) NSString *calcium;
@property (nonatomic, retain) NSString *iron;

+ (id)foodWithName:(NSString *)name
          category:(FoodCategory *)category
           context:(NSManagedObjectContext *)context;
+ (id)foodWithName:(NSString *)name
          category:(FoodCategory *)category
          calories:(NSString *)calories
     carbohidrates:(NSString *)carbohidrates
               fat:(NSString *)fat
          proteins:(NSString *)proteins
          vitaminA:(NSString *)vitaminA
          vitaminC:(NSString *)vitaminC
        properties:(NSString *)properties
           context:(NSManagedObjectContext *)context;
+ (id)foodWithName:(NSString *)name
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
           context:(NSManagedObjectContext *)context;
+ (id)foodWithName:(NSString *)name
          category:(FoodCategory *)category
 resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface FoodFile: ManagedObject

@property (nonatomic, retain) NSString *name;

+ (id)fileWithName:(NSString *)name
           context:(NSManagedObjectContext *)context;
+ (id)fileWithName:(NSString *)name
 resultsController:(NSFetchedResultsController *)resultsController;
+ (void)loadFromCSVinContext:(NSManagedObjectContext *)context;
+ (void)cleandata:(NSManagedObjectContext *)context;
@end