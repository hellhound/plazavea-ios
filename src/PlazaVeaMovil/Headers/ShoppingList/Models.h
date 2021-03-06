#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"
#import "Common/Models/ReorderingManagedObject.h"

@interface ShoppingList: ReorderingManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSSet *items;

+ (id)shoppingListWithName:(NSString *)name
                   context:(NSManagedObjectContext *)context;
+ (id)shoppingListWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController;
+ (NSString *)resolveNewNameFromName:(NSString *)name;

- (NSString *)formattedLastModiciationDate;
- (ShoppingList *)previous; // If there's no previous list, return the last one
- (ShoppingList *)next; // If there's no next list, return the first one
- (NSString *)serialize;
- (NSString *)serializeHTML;
@end

@interface ShoppingItem: ReorderingManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSNumber *checked;
@property (nonatomic, retain) ShoppingList *list;

+ (id)shoppingItemWithName:(NSString *)name
                  quantity:(NSString *)quantity
                      list:(ShoppingList *)shoppingList
                   context:(NSManagedObjectContext *)context;
+ (id)shoppingItemWithName:(NSString *)name
                  quantity:(NSString *)quantity
                      list:(ShoppingList *)shoppingList
         resultsController:(NSFetchedResultsController *)resultsController;

- (NSString *)serialize;
@end

@interface ShoppingHistoryEntry: ManagedObject

@property (nonatomic, retain) NSString *name;

+ (id)historyEntryWithName:(NSString *)name
                   context:(NSManagedObjectContext *)context;
+ (id)historyEntryWithName:(NSString *)name
         resultsController:(NSFetchedResultsController *)resultsController;
@end

@interface HistoryEntryFile: ManagedObject

@property (nonatomic, retain) NSString *name;

+ (id)fileWithName:(NSString *)name
           context:(NSManagedObjectContext *)context;
+ (id)fileWithName:(NSString *)name
 resultsController:(NSFetchedResultsController *)resultsController;
+ (void)loadFromCSVinContext:(NSManagedObjectContext *)context;
+ (void)cleandata:(NSManagedObjectContext *)context;
@end
