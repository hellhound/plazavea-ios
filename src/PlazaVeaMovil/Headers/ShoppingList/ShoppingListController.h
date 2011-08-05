#import "Application/AppDelegate.h"
#import "ShoppingList/ShoppingList.h"

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

- (void)addShoppingList:(NSString *)name;
- (void)changeName:(NSString *)name toShoppingList:(ShoppingList *)shoppingList;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)changeShoppingListNameHandler:(ShoppingList *)shoppingList;
- (void)cancelEditingHandler:(UIControl *)control;
- (void)performUndoHandler:(UIControl *)control;
- (void)performRedoHandler:(UIControl *)control;
@end

@interface ShoppingListController (CoreData)

- (void)performFetch;
- (void)updateUndoRedo;
@end
