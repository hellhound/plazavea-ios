#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListsController.h"

@interface ShoppingListController: EditableCellTableViewController
    <TSAlertViewDelegate>
{
    ShoppingListsController *_parentController;
    ShoppingList *_shoppingList;
}
@property (nonatomic, assign) ShoppingListsController *parentController;
@property (nonatomic, retain) ShoppingList *shoppingList;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList
          parentController:(ShoppingListsController *)parentController;
- (void)addShoppingList:(NSString *)name;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control;
- (void)addShoppingItemHandler:(UIControl *)control;
@end
