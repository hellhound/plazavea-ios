#import "Common/Views/InputView.h"

@class UITableViewController;
@class NSFetchRequest;
@class NSFetchedResultsController;
@protocol NSFetchedResultsControllerDelegate;

@interface ShoppingListController: UITableViewController
    <NSFetchedResultsControllerDelegate>
{
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_resultsController;
}
@end
