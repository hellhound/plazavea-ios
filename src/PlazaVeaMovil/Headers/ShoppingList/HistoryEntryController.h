#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"

@interface HistoryEntryController: EditableCellTableViewController

+ (NSPredicate *)predicateForItemsLikeName:(NSString *)name;
@end

@interface HistoryEntryController (EventHandler)
@end
