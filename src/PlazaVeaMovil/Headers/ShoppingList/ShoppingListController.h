#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/ShoppingList.h"

@interface ShoppingListController: EditableCellTableViewController
    <TSAlertViewDelegate>

- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)changeShoppingListNameHandler:(ShoppingList *)shoppingList;
@end
