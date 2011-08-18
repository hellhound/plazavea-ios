#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Models.h"

@interface TSAlertView (ModifyingShoppingItemAlertView)

+ (TSAlertView *)alertViewForModifyingShoppingItem:
    (id<TSAlertViewDelegate>)delegate
                                      shoppingItem:(ShoppingItem *)shoppingItem;
@end
