#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/TSAlertView+ModifyingShoppingItemAlertView.h"

@implementation TSAlertView (ModifyingShoppingItemAlertView)

#pragma mark -
#pragma mark TSAlertView (ModifyingShoppingItemAlertView)

+ (TSAlertView *)alertViewForModifyingShoppingItem:
    (id<TSAlertViewDelegate>)delegate
                                      shoppingItem:(ShoppingItem *)shoppingItem
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingItemModificationTitle, nil)
            message:nil
            delegate:delegate cancelButtonTitle:
                NSLocalizedString(kShoppingItemModificationCancelButtonTitle,
                    nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingItemModificationOkButtonTitle, nil),
                 nil] autorelease];

    [alertView setUserInfo:shoppingItem];
    [alertView setTag:kShoppingListAlertViewModifyingItem];
    [alertView setStyle:TSAlertViewStyleInput];
    [alertView addTextFieldWithLabel:
            kShoppingItemModificationQuantityPlaceholder];

    UITextField *nameTextField = [alertView textFieldAtIndex:0];
    UITextField *quantityTextField = [alertView textFieldAtIndex:1];

    [nameTextField setPlaceholder:kShoppingItemModificationNamePlaceholder];
    [nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameTextField setText:[shoppingItem name]];
    [quantityTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [quantityTextField setText:[shoppingItem quantity]];
    return alertView;
}
@end
