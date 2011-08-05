#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Views/InputView.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UIAlertViewDelegate)
@end

@implementation ShoppingListController (UIAlertViewDelegate)

#pragma mark -
#pragma mark <UIAlertViewDelegate>

- (void)            alertView:(InputView *)inputView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [inputView cancelButtonIndex]) {
        UITextField *textField = [inputView textField];
        NSString *text = [textField text];
        NSDictionary *userInfo = [inputView userInfo];

        switch ([inputView tag]) {
            case kShoppingListCreationTag:
                [self addShoppingList:text];
                break;
            case kShoppingListModificationTag:
                [self changeName:text toShoppingList:
                        [userInfo objectForKey:kShoppingListKey]];
                break;
        }
    }
}
@end
