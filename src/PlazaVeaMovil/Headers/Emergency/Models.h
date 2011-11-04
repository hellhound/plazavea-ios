#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"

@interface EmergencyCategory: ManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *numbers;

+ (id)categoryWithName:(NSString *)name
               context:(NSManagedObjectContext *)context;
+ (id)categoryWithName:(NSString *)name
     resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface EmergencyNumber: ManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) EmergencyCategory *category;

+ (id)numberWithName:(NSString *)name
               phone:(NSString *)phone
            category:(EmergencyCategory *)category
             context:(NSManagedObjectContext *)context;
+ (id)numberWithName:(NSString *)name
               phone:(NSString *)phone
            category:(EmergencyCategory *)category
   resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface EmergencyFile: ManagedObject

@property (nonatomic, retain) NSString *name;

+ (id)fileWithName:(NSString *)name
             context:(NSManagedObjectContext *)context;
+ (id)fileWithName:(NSString *)name
   resultsController:(NSFetchedResultsController *)resultsController;
@end
