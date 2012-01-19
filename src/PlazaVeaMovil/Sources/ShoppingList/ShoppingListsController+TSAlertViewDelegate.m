#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Models.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListsController.h"

@interface ShoppingListsController (TSAlertViewDelegate)
@end

@implementation ShoppingListsController (TSAlertViewDelegate)

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)            alertView:(TSAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([[alertView title] isEqualToString:kShoppingListsAlertTitle]) {
        if (buttonIndex == [alertView firstOtherButtonIndex]) {
            [self addShoppingListHandler:nil];
        }
    } else {
        if (buttonIndex != [alertView cancelButtonIndex])
            [self addShoppingList:[[alertView inputTextField] text]];
    }
}
@end
