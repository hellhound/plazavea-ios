#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/HistoryEntryController.h"

@class ShoppingListController;

@protocol ShoppingListControllerDelegate <NSObject>

@optional
- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name;
- (void)shoppingListController:(ShoppingListController *)shoppingListController
         didDeleteShoppingList:(ShoppingList *)shoppingList;
@end

@interface ShoppingListController: EditableCellTableViewController
    <UIActionSheetDelegate, TSAlertViewDelegate, HistoryEntryControllerDelegate>
{
    id<ShoppingListControllerDelegate> _delegate;
    ShoppingList *_shoppingList;
    UIBarButtonItem *_previousItem;
    UIBarButtonItem *_nextItem;
}
@property (nonatomic, retain) ShoppingList *shoppingList;
@property (nonatomic, assign) id<ShoppingListControllerDelegate> delegate;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList delegate:(id)delegate;
- (void)addShoppingList:(NSString *)name;
- (void)addShoppingItem:(NSString *)name quantity:(NSString *)quantity;
- (void)deleteShoppingList;
@end

@interface ShoppingListController (EventHandler)

- (void)previousList:(UIControl *)control;
- (void)nextList:(UIControl *)control;
- (void)addItemHandler:(UIControl *)control;
- (void)delete:(UIControl *)control;
- (void)displayActionSheet:(UIControl *)control;
@end
