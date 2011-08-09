#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/ShoppingList.h"
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

    if (buttonIndex == cancelButtonIndex) {
        [[self navigationController] popToRootViewControllerAnimated:YES];
    } else {
        [self addShoppingList:[[alertView inputTextField] text]];
    }
}
@end
