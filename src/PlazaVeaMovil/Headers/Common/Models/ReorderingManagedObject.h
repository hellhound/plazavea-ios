#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h" 

@protocol ReorderingManagedObject <NSObject>

@property (nonatomic, retain) NSNumber *order;
@end

@interface ReorderingManagedObject: ManagedObject <ReorderingManagedObject>

+ (id)orderedObjectWithContext:(NSManagedObjectContext *)context;
+ (id)orderedObjectWithResultsController:
    (NSFetchedResultsController *)resultsController;
@end
