#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (TSAlertViewDelegate)
@end

@implementation ShoppingListController (TSAlertViewDelegate)

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)            alertView:(TSAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSInteger cancelButtonIndex = [alertView cancelButtonIndex];

    switch ([alertView tag]) {
        case kShoppingListAlertViewNewList:
            if (buttonIndex == cancelButtonIndex) {
                [[self navigationController]
                        popToRootViewControllerAnimated:YES];
            } else {
                [self addShoppingList:[[alertView firstTextField] text]];
            }
            break;
        case kShoppingListAlertViewNewItem:
            if (buttonIndex != cancelButtonIndex) {
                UITextField *nameTextField = [alertView textFieldAtIndex:0];
                UITextField *quantityTextField = [alertView textFieldAtIndex:1];

                [self addShoppingItem:[nameTextField text]
                        quantity:[quantityTextField text]];
            }
            break;
        case kShoppingListAlertViewListDeletion:
            if (buttonIndex != cancelButtonIndex)
                [self deleteShoppingList];
            break;
    }
}
@end
