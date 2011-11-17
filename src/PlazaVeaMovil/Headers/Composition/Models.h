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

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *calories;
@property (nonatomic, retain) NSNumber *carbohidates;
@property (nonatomic, retain) NSNumber *fat;
@property (nonatomic, retain) NSNumber *proteins;
@property (nonatomic, retain) NSNumber *vitaminA;
@property (nonatomic, retain) NSNumber *vitaminC;
@property (nonatomic, retain) FoodCategory *category;

+ (id)foodWithName:(NSString *)name
            category:(FoodCategory *)category
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