// Shopping-list module's constants
#import <Foundation/Foundation.h>

#import "ShoppingList/Constants.h"

// ShoppingList model's constants

NSString *const kShoppingListEntity = @"ShoppingList";
NSString *const kShoppingListClass = @"ShoppingList";
NSString *const kShoppingListName = @"name";
NSString *const kShoppingListLastModificationDate = @"lastModificationDate";
NSString *const kShoppingListOrder = @"order";
NSString *const kShoppingListItems = @"items";

// ShoppingItem model's constants

NSString *const kShoppingItemEntity = @"ShoppingItem";
NSString *const kShoppingItemClass = @"ShoppingItem";
NSString *const kShoppingItemName = @"name";
NSString *const kShoppingItemQuantity = @"quantity";
NSString *const kShoppingItemChecked = @"checked";
NSString *const kShoppingItemOrder = @"order";
NSString *const kShoppingItemList = @"list";

// ShoppingListController's constants

// Administration of shopping lists
NSString *const kShoppingListTitle = @"Mis listas";
// NSLocalizedString(@"Mis listas", nil)
// Fetch-request controller cache's file name
NSString *const kShoppingListCacheName = @"ShoppingListController.cache";
// Default detail text
NSString *const kShoppingListDefaultDetailText = @"Nuevo";
// NSLocalizedString(@"Nuevo", nil)
// ShoppingList's key for InputView's userInfo dictionary
NSString *const kShoppingListKey = @"shoppingList";

// InputView's constants for shopping list creation
NSString *const kShoppingListNewTitle = @"Nueva lista";
// NSLocalizedString(@"Nueva lista", nil)
NSString *const kShoppingListNewMessage = @"Ingrese el nombre de la nueva "
        @"lista de compras";
// NSLocalizedString(@"Ingrese el nombre de la nueva lista de "
//      @"compras", nil)
NSString *const kShoppingListNewOkButtonTitle = @"Ok";
// NSLocalizedString(@"Ok", nil)
NSString *const kShoppingListNewCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)
