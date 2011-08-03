#import "Common/Views/InputView.h"

@class UITableViewController;
@class NSFetchRequest;
@class NSFetchedResultsController;
@protocol NSFetchedResultsControllerDelegate;
@protocol UIAlertViewDelegate;

@interface ShoppingListController: UITableViewController
    <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>
{
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_resultsController;
}
@end
