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
@end

@interface ShoppingListController: EditableCellTableViewController
    <UINavigationControllerDelegate, TSAlertViewDelegate,
    HistoryEntryControllerDelegate>
{
    id<ShoppingListControllerDelegate> _delegate;
    ShoppingList *_shoppingList;
}
@property (nonatomic, retain) ShoppingList *shoppingList;
@property (nonatomic, assign) id<ShoppingListControllerDelegate> delegate;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList delegate:(id)delegate;
- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)addItemHandler:(UIControl *)control;
@end
