#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

@interface TSAlertView (ShoppingListDeletionConfirmation)

+ (TSAlertView *)alertViewForShoppingListDeletion:
    (id<TSAlertViewDelegate>)delegate;
@end
