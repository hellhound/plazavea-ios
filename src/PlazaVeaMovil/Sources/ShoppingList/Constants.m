// Shopping-list module's constants
#import <Foundation/Foundation.h>

#import "ShoppingList/Constants.h"

// ShoppingList model's constants

NSString *const kShoppingListEntity = @"ShoppingList";
NSString *const kShoppingListClass = @"ShoppingList";
NSString *const kShoppingListName = @"name";
NSString *const kShoppingListLastModificationDate = @"lastModificationDate";
NSString *const kShoppingListItems = @"items";

// ShoppingItem model's constants

NSString *const kShoppingItemEntity = @"ShoppingItem";
NSString *const kShoppingItemClass = @"ShoppingItem";
NSString *const kShoppingItemName = @"name";
NSString *const kShoppingItemQuantity = @"quantity";
NSString *const kShoppingItemChecked = @"checked";
NSString *const kShoppingItemList = @"list";

// ShoppingHistoryEntry model's constants

NSString *const kShoppingHistoryEntryEntity = @"ShoppingHistoryEntry";
NSString *const kShoppingHistoryEntryClass = @"ShoppingHistoryEntry";
NSString *const kShoppingHistoryEntryName = @"name";

// ShoppingListController's constants

// Administration of shopping lists
NSString *const kShoppingListTitle = @"Mis listas";
// NSLocalizedString(@"Mis listas", nil)
// Fetch-request controller cache's file name
NSString *const kShoppingListCacheName = @"ShoppingListController.cache";
// Default detail text
NSString *const kShoppingListDefaultDetailText = @"Nuevo";
// NSLocalizedString(@"Nuevo", nil)

// TSAlertView's constants for shopping list creation
NSString *const kShoppingListNewTitle = @"Nueva lista";
// NSLocalizedString(@"Nueva lista", nil)
NSString *const kShoppingListNewPlaceholder = @"Nombre de la nueva lista";
// NSLocalizedString(@"Nombre de la nueva lista", nil)
NSString *const kShoppingListNewOkButtonTitle = @"Ok";
// NSLocalizedString(@"Ok", nil)
NSString *const kShoppingListNewCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)

// ShoppingListController's constants

const NSTimeInterval kNewShoppingListAlertViewDelay = .1;

// HistoryEntryControlller's contstants

// Administration of history entries
NSString *const kHistoryEntryTitle = @"Historial de ítems";
// NSLocalizedString(@"Historial de ítems", nil)
