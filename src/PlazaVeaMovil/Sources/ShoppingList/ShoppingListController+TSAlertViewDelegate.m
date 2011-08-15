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
                [self addShoppingList:[[alertView inputTextField] text]];
            }
            break;
        case kShoppingListAlertViewNewItem:
            break;
    }
}
@end
