#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/TSAlertView+NewShoppingItemAlertView.h"

@implementation TSAlertView (NewShoppingItemAlertView)

#pragma mark -
#pragma mark TSAlertView (NewShoppingItemAlertView)

+ (TSAlertView *)alertViewForNewShoppingItem:(id<TSAlertViewDelegate>)delegate
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingItemNewTitle, nil)
            message:nil
            delegate:delegate cancelButtonTitle:
                NSLocalizedString(kShoppingItemNewCancelButtonTitle, nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingItemNewOkButtonTitle, nil),
                 nil] autorelease];
    UITextField *textField = [alertView inputTextField];

    [alertView setTag:kShoppingListAlertViewNewItem];
    [alertView setStyle:TSAlertViewStyleInput];
    [textField setPlaceholder:kShoppingItemNewPlaceholder];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    return alertView;
}
@end
