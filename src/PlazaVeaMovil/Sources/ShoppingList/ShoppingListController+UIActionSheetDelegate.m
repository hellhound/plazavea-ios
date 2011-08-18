#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UIActionSheetDelegate)
@end

@implementation ShoppingListController (UIActionSheetDelegate)

#pragma mark -
#pragma mark <UIActionSheetDelegate>

- (void)        actionSheet:(UIActionSheet *)actionSheet
  didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case kShoppingListActionSheetNewButtonIndex:
            [self createNewShoppingListFromActionSheet:YES];
            break;
        case kShoppingListActionSheetCloneButtonIndex:
            break;
        case kShoppingListActionSheetMailButtonIndex:
            break;
    }
}
@end
