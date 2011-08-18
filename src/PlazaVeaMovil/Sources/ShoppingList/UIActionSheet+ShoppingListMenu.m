#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/UIActionSheet+ShoppingListMenu.h"

@implementation UIActionSheet (ShoppingListMenu)

#pragma mark -
#pragma mark UIActionSheet (ShoppingListMenu)

+ (UIActionSheet *)actionSheetForShoppingListMenu:
    (id<UIActionSheetDelegate>)delegate
{
    UIActionSheet *actionSheet =
        [[[UIActionSheet alloc] initWithTitle:nil delegate:delegate
            cancelButtonTitle:kShoppingListActionSheetCancelButtonTitle
        destructiveButtonTitle:nil
        otherButtonTitles:
            kShoppingListActionSheetNewButtonTitle,
            kShoppingListActionSheetCloneButtonTitle,
            kShoppingListActionSheetMailButtonTitle, nil] autorelease];
    
    return actionSheet;
}
@end
