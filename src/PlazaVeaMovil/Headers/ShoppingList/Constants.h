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
extern NSString *const kShoppingCreateList;
// Fetch-request controller cache's file name
extern NSString *const kShoppingListCacheName;
// Default detail text
extern NSString *const kShoppingListDefaultDetailText;
extern NSString *const kShoppingListCloningRepetitionName;
extern NSString *const kShoppingListCloningRepetitionPattern;
extern NSString *const kShoppingListCloningRepetitionSuffix;

typedef enum {
    kShoppingListAlertViewNewList,
    kShoppingListAlertViewNewItem,
    kShoppingListAlertViewModifyingItem,
    kShoppingListAlertViewListDeletion,
    kShoppingListAlertViewActionSheetNewList
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
extern const NSUInteger kShoppingItemNewBlankCheckingFlags;

// TSAlertView's constants for shopping item modification
extern NSString *const kShoppingItemModificationTitle;
extern NSString *const kShoppingItemModificationNamePlaceholder;
extern NSString *const kShoppingItemModificationQuantityPlaceholder;
extern NSString *const kShoppingItemModificationOkButtonTitle;
extern NSString *const kShoppingItemModificationCancelButtonTitle;
extern const NSUInteger kShoppingItemModificationBlankCheckingFlags;

// TSAlertView's constants for shopping list deletion
extern NSString *const kShoppingListDeletionTitle;
extern NSString *const kShoppingListDeletionMessage;
extern NSString *const kShoppingListDeletionOkButtonTitle;
extern NSString *const kShoppingListDeletionCancelButtonTitle;

typedef enum {
    kShoppingListActionSheetNewButtonIndex,
    kShoppingListActionSheetCloneButtonIndex,
    kShoppingListActionSheetMailButtonIndex
} ShoppingListActionSheetIndex;

// UIActionSheet's constants
extern NSString *const kShoppingListActionSheetNewButtonTitle;
extern NSString *const kShoppingListActionSheetCloneButtonTitle;
extern NSString *const kShoppingListActionSheetMailButtonTitle;
extern NSString *const kShoppingListActionSheetCancelButtonTitle;

// ShoppingListController's constants

extern const NSTimeInterval kShoppingListAlertViewDelay;

// HistoryEntryControlller's contstants

// Administration of history entries
extern NSString *const kHistoryEntryTitle;

// Controller URLs

extern NSString *const kURLShoppingLists;

// Controller URL's calls

extern NSString *const kURLShoppingListsCall;
