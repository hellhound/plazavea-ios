#import "Application/AppDelegate.h"

@class UITableViewController;
@class NSFetchRequest;
@class NSFetchedResultsController;
@class UIBarButtonItem;
@protocol NSFetchedResultsControllerDelegate;
@protocol UIAlertViewDelegate;

@interface ShoppingListController: UITableViewController
    <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>
{
    AppDelegate *_appDelegate;
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_resultsController;
    // Undo management items
    UIBarButtonItem *_undoItem;
    UIBarButtonItem *_redoItem;
}
@end

@interface ShoppingListController (CoreData)

- (void)performFetch;
- (void)updateUndoRedo;
@end
