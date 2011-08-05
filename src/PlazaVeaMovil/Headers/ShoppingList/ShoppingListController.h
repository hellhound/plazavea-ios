#import "Common/Controllers/EditableTableViewController.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/ShoppingList.h"

@protocol UIAlertViewDelegate;

@interface ShoppingListController: EditableTableViewController
    <UIAlertViewDelegate>

- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)changeShoppingListNameHandler:(ShoppingList *)shoppingList;
@end
