#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"

@interface HistoryEntryController: EditableCellTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSFetchedResultsController *_filteredResultsController;
    UISearchDisplayController *_searchController;
}
@property (nonatomic, readonly)
    NSFetchedResultsController *filteredResultsController;

+ (NSPredicate *)predicateForItemsLikeName:(NSString *)name;
@end

@interface HistoryEntryController (EventHandler)
@end
