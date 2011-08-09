#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/EditableTableViewController+NewShoppingListAlertView.h"

@implementation EditableTableViewController (NewShoppingListAlertView)

#pragma mark -
#pragma mark EditableTableViewController (NewShoppingListAlertView)

- (TSAlertView *)alertViewForNewShoppingList
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingListNewTitle, nil)
            message:nil
            delegate:self cancelButtonTitle:
                NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                 nil] autorelease];
    UITextField *textField = [alertView inputTextField];

    [alertView setStyle:TSAlertViewStyleInput];
    [textField setPlaceholder:kShoppingListNewPlaceholder];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    return alertView;
}
@end
