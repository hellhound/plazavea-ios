#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/TSAlertView+ShoppingListDeletionConfirmation.h"

@implementation TSAlertView (ShoppingListDeletionConfirmation)

#pragma mark -
#pragma mark TSAlertView (ShoppingListDeletionConfirmation)

+ (TSAlertView *)alertViewForShoppingListDeletion:
    (id<TSAlertViewDelegate>)delegate
{
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:
                NSLocalizedString(kShoppingListDeletionTitle, nil)
            message:NSLocalizedString(kShoppingListDeletionMessage, nil)
            delegate:delegate cancelButtonTitle:
                NSLocalizedString(kShoppingListDeletionCancelButtonTitle, nil)
            otherButtonTitles:
                NSLocalizedString(kShoppingListDeletionOkButtonTitle, nil),
                 nil] autorelease];

    [alertView setTag:kShoppingListAlertViewListDeletion];
    return alertView;
}
@end
