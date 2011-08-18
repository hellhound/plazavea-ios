#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

@interface TSAlertView (NewShoppingListAlertView)

+ (TSAlertView *)alertViewForNewShoppingList:(id<TSAlertViewDelegate>)delegate
                             fromActionSheet:(BOOL)fromActionSheet;
@end
