#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingItemAlertView.h"

@implementation TSAlertView (NewShoppingItemAlertView)

#pragma mark -
#pragma mark TSAlertView (NewShoppingItemAlertView)

+ (TSAlertView *)alertViewForNewShoppingItem:(id<TSAlertViewDelegate>)delegate
                                historyEntry:
    (ShoppingHistoryEntry *)historyEntry
                                    withText:(NSString *)text
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingItemNewTitle, nil)
            message:nil
            delegate:delegate cancelButtonTitle:
                NSLocalizedString(kShoppingItemNewCancelButtonTitle, nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingItemNewOkButtonTitle, nil),
                 nil] autorelease];

    [alertView setTag:kShoppingListAlertViewNewItem];
    [alertView setStyle:TSAlertViewStyleInput];
    [alertView addTextFieldWithLabel:kShoppingItemNewQuantityPlaceholder];

    UITextField *nameTextField = [alertView textFieldAtIndex:0];
    UITextField *quantityTextField = [alertView textFieldAtIndex:1];

    [nameTextField setPlaceholder:kShoppingItemNewNamePlaceholder];
    [nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameTextField setText:
            historyEntry != nil ? [historyEntry name] :
            text != nil ? text : @""];
    [quantityTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [quantityTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [alertView setShouldNotAdmitBlanks:kShoppingItemNewBlankCheckingFlags];
    return alertView;
}
@end
