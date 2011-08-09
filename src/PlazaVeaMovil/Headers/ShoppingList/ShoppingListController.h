#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/ShoppingList.h"

@interface ShoppingListController: EditableCellTableViewController
    <TSAlertViewDelegate>
{
    ShoppingList *_shoppingList;
}

- (id)initWithShoppingList:(ShoppingList *)shoppingList;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)addShoppingItemHandler:(UIControl *)control;
@end
