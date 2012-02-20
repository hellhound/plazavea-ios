// Shopping-list module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
NSString *const kShoppingListTitle = @"Mis Listas";
// NSLocalizedString(@"Mis listas", nil)
NSString *const kShoppingCreateList = @"Crear Lista";
// NSLocalizedString(@"Crear Lista", nil)
// Fetch-request controller cache's file name
NSString *const kShoppingListCacheName = @"ShoppingListController.cache";
// Default detail text
NSString *const kShoppingListDefaultDetailText = @"Nuevo";
// NSLocalizedString(@"Nuevo", nil)
NSString *const kShoppingListCloningRepetitionName = @"Copia";
// NSLocalizedString(@"Copia", nil)
NSString *const kShoppingListCloningRepetitionPattern =
        @"%@\\s*\\(\\s*%@\\s*\\d+\\s*\\)";
// NSLocalizedString(@"%@\\s*\\(\\s*%@\\s*\\d+\\s*\\)", nil)
NSString *const kShoppingListCloningRepetitionSuffix = @"%@ (%@ %li)";
// NSLocalizedString(@" (%@)", nil)
NSString *const kShoppingListsAlertTitle = @"No tienes ninguna lista";
// NSLocalizedString(@"No tienes ninguna lista", nil)
NSString *const kShoppingListsAlertMessage = @"Para empezar a crear una lista "\
        @"solo debes presionar el símbolo + en la parte inferior";
// NSLocalizedString(@"Para empezar a crear una lista "\
        @"solo debes presionar el símbolo + en la parte inferior", nil)
NSString *const kShoppingListsAlertCancel = @"OK";
// NSLocalizedString(@"OK", nil)
NSString *const kShoppingListsAlertCreate = @"Crear lista";
// NSLocalizedString(@"Crear", nil)
NSString *const kShoppingListsDefaultBanner =
        @"default-banner-shopping-list.png";
const CGFloat kShoppingListsBannerHeight = 140.;
const CGFloat kShoppingListsBannerWidth = 320.;

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
NSString *const kShoppingListDeletionTitle = @"";
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
NSString *const kShoppingListActionSheetCloneButtonTitle = @"Duplicar lista";
// NSLocalizedString(@"Duplicar lista", nil)
NSString *const kShoppingListActionSheetMailButtonTitle = @"Enviar vía email";
// NSLocalizedString(@"Enviar vía email", nil)
NSString *const kShoppingListActionSheetCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)

// ShoppingListController's constants

const NSTimeInterval kShoppingListAlertViewDelay = .25;
NSString *const kShoppingListAlertTitle = @"Lista vacía";
// NSLocalizedString(@"Lista vacía", nil)
NSString *const kShoppingListAlertMessage = @"Empieza a agregar ítems "\
        @"a tu lista presionando el símbolo + de la parte inferior";
// NSLocalizedString(@"Empieza a agregar ítems "\
        @"a tu lista presionando el símbolo + de la parte inferior", nil)
NSString *const kShoppingListAlertCancel = @"OK";
// NSLocalizedString(@"OK", nil)
NSString *const kShoppingListAlertCreate = @"Agregar ítems";
// NSLocalizedString(@"Agregar ítems", nil)
NSString *const kShoppingListMailSubject = @"Plaza Vea te envía la lista: %@";
// NSLocalizedString(@"Plaza Vea te envía esta lista: %@", nil)
NSString *const kShoppingListMailHeader = @"default-store-detail.png";
NSString *const kShoppingListMailFooter = @"Tú también puedes crear tu " \
        "propia lista en Plaza Vea móvil ingresa aquí.";
// NSLocalizedString(@"Tú también puedes crear tu " \
//      "propia lista en Plaza Vea móvil ingresa aquí.", nil)

// HistoryEntryControlller's contstants
NSString *const kHistoryEntryAlertTitle = @"Lista vacía";
// NSLocalizedString(@"Lista vacía", nil)
NSString *const kHistoryEntryAlertMessage = @"Empieza a agregar ítems "\
        @"presionando el símbolo + de la parte inferior";
// NSLocalizedString(@"Empieza a agregar ítems "\
        @"presionando el símbolo + de la parte inferior", nil)
NSString *const kHistoryEntryAlertCancel = @"OK";
// NSLocalizedString(@"OK", nil)
NSString *const kHistoryEntryAlertCreate = @"Agregar ítems";
// NSLocalizedString(@"Agregar ítems", nil)

// Administration of history entries
NSString *const kHistoryEntryTitle = @"Historial de ítems";
// NSLocalizedString(@"Historial de ítems", nil)

// Controller URLs

NSString *const kURLShoppingLists = @"tt://launcher/shoppinglists/";

// Controller URL's calls

NSString *const kURLShoppingListsCall = @"tt://launcher/shoppinglists/";
