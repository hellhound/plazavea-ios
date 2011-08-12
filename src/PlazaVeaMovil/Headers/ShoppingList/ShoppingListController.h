#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"

@interface ShoppingListController: EditableCellTableViewController
    <TSAlertViewDelegate>
{
    id _delegate;
    ShoppingList *_shoppingList;
}
@property (nonatomic, retain) ShoppingList *shoppingList;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList delegate:(id)delegate;
- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)addShoppingItemHandler:(UIControl *)control;
@end

@protocol ShoppingListControllerDelegate

- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name;
@end
