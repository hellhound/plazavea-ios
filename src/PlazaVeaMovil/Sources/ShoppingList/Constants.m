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
// Quantity should be optional
const NSUInteger kShoppingItemNewBlankCheckingFlags = 1 << 0;

// TSAlertView's constants for shopping item creation
NSString *const kShoppingItemNewTitle = @"Nuevo ítem";
// NSLocalizedString(@"Nuevo ítem", nil)
NSString *const kShoppingItemNewNamePlaceholder = @"Descripción del ítem";
// NSLocalizedString(@"Descripción del ítem", nil)
NSString *const kShoppingItemNewQuantityPlaceholder = @"Cantidad";
// NSLocalizedString(@"Cantidad", nil)
NSString *const kShoppingItemNewOkButtonTitle = @"Ok";
// NSLocalizedString(@"Ok", nil)
NSString *const kShoppingItemNewCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)
// Quantity should be optional
const NSUInteger kShoppingItemModificationBlankCheckingFlags = 1 << 0;

// TSAlertView's constants for shopping item modification
NSString *const kShoppingItemModificationTitle = @"Modificación de ítem";
// NSLocalizedString(@"Modificación de ítem", nil)
NSString *const kShoppingItemModificationNamePlaceholder =
        @"Descripción del ítem";
// NSLocalizedString(@"Descripción del ítem", nil)
NSString *const kShoppingItemModificationQuantityPlaceholder = @"Cantidad";
// NSLocalizedString(@"Cantidad", nil)
NSString *const kShoppingItemModificationOkButtonTitle = @"Ok";
// NSLocalizedString(@"Ok", nil)
NSString *const kShoppingItemModificationCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)

// TSAlertView's constants for shopping list deletion
NSString *const kShoppingListDeletionTitle = @"Eliminación de lista";
// NSLocalizedString(@"Eliminación de lista", nil)
NSString *const kShoppingListDeletionMessage = @"¿Está seguro de eliminar la " \
        @"lista de compras?";
// NSLocalizedString(@"¿Está seguro de eliminar la lista de compras?", nil)
NSString *const kShoppingListDeletionOkButtonTitle = @"Sí";
// NSLocalizedString(@"Sí", nil)
NSString *const kShoppingListDeletionCancelButtonTitle = @"No";
// NSLocalizedString(@"No", nil)

// UIActionSheet's constants
NSString *const kShoppingListActionSheetNewButtonTitle = @"Nueva lista";
// NSLocalizedString(@"Nueva lista", nil)
NSString *const kShoppingListActionSheetCloneButtonTitle = @"Clonar lista";
// NSLocalizedString(@"Clonar lista", nil)
NSString *const kShoppingListActionSheetMailButtonTitle = @"Enviar vía email";
// NSLocalizedString(@"Enviar vía email", nil)
NSString *const kShoppingListActionSheetCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)

// ShoppingListController's constants

const NSTimeInterval kShoppingListAlertViewDelay = .25;

// HistoryEntryControlller's contstants

// Administration of history entries
NSString *const kHistoryEntryTitle = @"Historial de ítems";
// NSLocalizedString(@"Historial de ítems", nil)

// Controller URLs

NSString *const kURLShoppingLists = @"tt://launcher/shoppinglists/";

// Controller URL's calls

NSString *const kURLShoppingListsCall = @"tt://launcher/shoppinglists/";
