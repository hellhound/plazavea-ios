#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListsController.h"

@interface ShoppingListsController (TSAlertViewDelegate)
@end

@implementation ShoppingListsController (TSAlertViewDelegate)

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)            alertView:(TSAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
        [self addShoppingList:[[alertView inputTextField] text]];
}
@end
