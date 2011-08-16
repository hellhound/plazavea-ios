#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"
#import "Common/Models/ReorderingManagedObject.h"

@interface ShoppingList: ReorderingManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSSet *items;

+ (id)shoppingListWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController;

- (NSString *)formattedLastModiciationDate;
@end

@interface ShoppingItem: ReorderingManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSNumber *checked;
@property (nonatomic, retain) ShoppingList *list;

+ (id)shoppingItemWithName:(NSString *)name
                  quantity:(NSString *)quantity
                      list:(ShoppingList *)shoppingList
         resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface ShoppingHistoryEntry: ManagedObject

@property (nonatomic, retain) NSString *name;

+ (id)historyEntryWithName:(NSString *)name
                   context:(NSManagedObjectContext *)context;
+ (id)historyEntryWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController;
@end
