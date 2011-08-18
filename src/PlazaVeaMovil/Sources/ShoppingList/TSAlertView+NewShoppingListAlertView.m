#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"

@implementation TSAlertView (NewShoppingListAlertView)

#pragma mark -
#pragma mark TSAlertView (NewShoppingListAlertView)

+ (TSAlertView *)alertViewForNewShoppingList:(id<TSAlertViewDelegate>)delegate
                             fromActionSheet:(BOOL)fromActionSheet
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingListNewTitle, nil)
            message:nil
            delegate:delegate cancelButtonTitle:
                NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                 nil] autorelease];
    UITextField *textField = [alertView inputTextField];

    [alertView setTag:fromActionSheet ?
        kShoppingListAlertViewActionSheetNewList :
        kShoppingListAlertViewNewList];
    [alertView setStyle:TSAlertViewStyleInput];
    [textField setPlaceholder:kShoppingListNewPlaceholder];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    return alertView;
}
@end
