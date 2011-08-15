#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListController.h"

@interface HistoryEntryController: EditableCellTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate,
    ShoppingListControllerDelegate>
{
    NSFetchedResultsController *_filteredResultsController;
    UISearchDisplayController *_searchController;
}
@property (nonatomic, readonly)
    NSFetchedResultsController *filteredResultsController;

+ (NSPredicate *)predicateForEntriesLikeName:(NSString *)name;
@end

@interface HistoryEntryController (EventHandler)
@end
