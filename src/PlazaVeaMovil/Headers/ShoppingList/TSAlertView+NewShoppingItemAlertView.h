#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "ShoppingList/Models.h"

@interface TSAlertView (NewShoppingItemAlertView)

+ (TSAlertView *)alertViewForNewShoppingItem:(id<TSAlertViewDelegate>)delegate
                                historyEntry:
    (ShoppingHistoryEntry *)historyEntry
                                    withText:(NSString *)text;
@end
