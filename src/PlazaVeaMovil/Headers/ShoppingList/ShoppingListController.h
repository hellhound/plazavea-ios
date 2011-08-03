#import "Common/Views/InputView.h"

@class UITableViewController;
@class NSFetchRequest;
@class NSFetchedResultsController;
@class UIBarButtonItem;
@protocol NSFetchedResultsControllerDelegate;
@protocol UIAlertViewDelegate;

@interface ShoppingListController: UITableViewController
    <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>
{
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_resultsController;
    // Undo management items
    UIBarButtonItem *_undoItem;
    UIBarButtonItem *_redoItem;
}
@end
