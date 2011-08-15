#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

@interface TSAlertView (NewShoppingItemAlertView)

+ (TSAlertView *)alertViewForNewShoppingItem:(id<TSAlertViewDelegate>)delegate;
@end
