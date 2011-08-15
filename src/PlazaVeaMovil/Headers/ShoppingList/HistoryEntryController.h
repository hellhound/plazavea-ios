#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"

@class HistoryEntryController;

@protocol HistoryEntryControllerDelegate <NSObject>

@optional
// history entry can be nil; thus differentiating between an insert and a
// selection
- (void)historyEntryController:(HistoryEntryController *)historyEntryController
                  historyEntry:(ShoppingHistoryEntry *)historyEntry;
@end

@interface HistoryEntryController: EditableCellTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate>
{
    id<HistoryEntryControllerDelegate> _delegate;
    NSFetchedResultsController *_filteredResultsController;
    UISearchDisplayController *_searchController;
}
@property (nonatomic, assign) id<HistoryEntryControllerDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

+ (NSPredicate *)predicateForEntriesLikeName:(NSString *)name;
@end

@interface HistoryEntryController (EventHandler)

- (void)addHistoryEntry:(UIControl *)control;
@end
