#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "Common/Views/BZActionSheet.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/HistoryEntryController.h"

@class ShoppingListController;

@protocol ShoppingListControllerDelegate <NSObject, NSCoding>

@optional
- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name;
- (void)shoppingListController:(ShoppingListController *)shoppingListController
         didDeleteShoppingList:(ShoppingList *)shoppingList;
- (void)shoppingListController:(ShoppingListController *)shoppingListController
          didCloneShoppingList:(ShoppingList *)shoppingList;
@end

@interface ShoppingListController: EditableTableViewController
    <UIActionSheetDelegate, MFMailComposeViewControllerDelegate,
    TSAlertViewDelegate, HistoryEntryControllerDelegate, BZActionSheetDelegate>
{
    UIViewController<ShoppingListControllerDelegate> *_delegate;
    ShoppingList *_shoppingList;
    UIBarButtonItem *_previousItem;
    UIBarButtonItem *_nextItem;
}
@property (nonatomic, retain) ShoppingList *shoppingList;
@property (nonatomic, assign) 
    UIViewController<ShoppingListControllerDelegate> *delegate;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList;

- (id)initWithShoppingList:(ShoppingList *)shoppingList delegate:(id)delegate;
- (void)addShoppingItem:(NSString *)name quantity:(NSString *)quantity;
- (void)modifyShoppingItem:(ShoppingItem *)shoppingItem
                      name:(NSString *)name
                  quantity:(NSString *)quantity;
- (void)deleteShoppingList;
- (void)createNewShoppingListFromActionSheet:(BOOL)fromActionSheet;
@end

@interface ShoppingListController (EventHandler)

- (void)addShoppingList:(NSString *)name fromActionSheet:(BOOL)fromActionSheet;
- (void)previousList:(UIControl *)control;
- (void)nextList:(UIControl *)control;
- (void)addItem:(UIControl *)control;
- (void)delete:(UIControl *)control;
- (void)displayActionSheet:(UIControl *)control;
- (void)cloneShoppingList;
- (void)mailShoppingList;
@end
