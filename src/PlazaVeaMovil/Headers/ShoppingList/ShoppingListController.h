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
