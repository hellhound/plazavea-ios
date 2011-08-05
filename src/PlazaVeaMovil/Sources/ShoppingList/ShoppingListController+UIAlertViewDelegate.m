#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Views/InputView.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UIAlertViewDelegate)
@end

@implementation ShoppingListController (UIAlertViewDelegate)

#pragma mark -
#pragma mark <UIAlertViewDelegate>

- (void)            alertView:(InputView *)inputView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [inputView cancelButtonIndex])
        [self addShoppingList:[[inputView textField] text]];
}
@end
