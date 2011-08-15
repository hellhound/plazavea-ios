#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"

@class ShoppingListController;

@protocol ShoppingListControllerDelegate <NSObject>

@optional
- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name;
@end

@interface ShoppingListController: EditableCellTableViewController
    <TSAlertViewDelegate>
{
    id<ShoppingListControllerDelegate> _delegateForAdding;
    id<ShoppingListControllerDelegate> _delegateForInsertingItem;
    ShoppingList *_shoppingList;
}
@property (nonatomic, retain) ShoppingList *shoppingList;
@property (nonatomic,
        assign) id<ShoppingListControllerDelegate> delegateForAdding;
@property (nonatomic,
        assign) id<ShoppingListControllerDelegate> delegateForInsertingItem;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList
         delegateForAdding:(id)delegate;
- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)addItemHandler:(UIControl *)control;
@end
