#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableTableViewController.h"

@interface EditableTableViewController (NewShoppingListAlertView)

- (TSAlertView *)alertViewForNewShoppingList;
@end
