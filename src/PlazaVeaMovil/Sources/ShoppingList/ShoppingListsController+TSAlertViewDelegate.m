#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListsController.h"

@interface ShoppingListsController (TSAlertViewDelegate)
@end

@implementation ShoppingListsController (TSAlertViewDelegate)

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)            alertView:(TSAlertView *)inputView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [inputView cancelButtonIndex])
        [self addShoppingList:[[inputView inputTextField] text]];
}
@end
