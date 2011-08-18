#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIActionSheet (ShoppingListMenu)

+ (UIActionSheet *)actionSheetForShoppingListMenu:
    (id<UIActionSheetDelegate>)delegate;
@end
