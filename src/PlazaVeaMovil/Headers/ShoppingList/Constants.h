// Shopping-list module's constants
#import <Foundation/Foundation.h>

#import "Common/Models/Constants.h"

// ShoppingList model's constants

extern NSString *const kShoppingListEntity;
extern NSString *const kShoppingListClass;
extern NSString *const kShoppingListName;
extern NSString *const kShoppingListLastModificationDate;
extern NSString *const kShoppingListItems;

// ShoppingItem model's constants

extern NSString *const kShoppingItemEntity;
extern NSString *const kShoppingItemClass;
extern NSString *const kShoppingItemName;
extern NSString *const kShoppingItemQuantity;
extern NSString *const kShoppingItemChecked;
extern NSString *const kShoppingItemList;

// ShoppingHistoryEntry model's constants

extern NSString *const kShoppingHistoryEntryEntity;
extern NSString *const kShoppingHistoryEntryClass;
extern NSString *const kShoppingHistoryEntryName;

// ShoppingListsController's constants

// Administration of shopping lists
extern NSString *const kShoppingListTitle;
// Fetch-request controller cache's file name
extern NSString *const kShoppingListCacheName;
// Default detail text
extern NSString *const kShoppingListDefaultDetailText;

typedef enum {
    kShoppingListAlertViewNewList,
    kShoppingListAlertViewNewItem
} ShoppingListAlertViewType;

// TSAlertView's constants for shopping list creation
extern NSString *const kShoppingListNewTitle;
extern NSString *const kShoppingListNewPlaceholder;
extern NSString *const kShoppingListNewOkButtonTitle;
extern NSString *const kShoppingListNewCancelButtonTitle;

// TSAlertView's constants for shopping item creation
extern NSString *const kShoppingItemNewTitle;
extern NSString *const kShoppingItemNewNamePlaceholder;
extern NSString *const kShoppingItemNewQuantityPlaceholder;
extern NSString *const kShoppingItemNewOkButtonTitle;
extern NSString *const kShoppingItemNewCancelButtonTitle;

// ShoppingListController's constants

extern const NSTimeInterval kShoppingListAlertViewDelay;

// HistoryEntryControlller's contstants

// Administration of history entries
extern NSString *const kHistoryEntryTitle;
