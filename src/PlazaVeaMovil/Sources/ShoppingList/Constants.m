// Shopping-list module's constants
#import <Foundation/Foundation.h>

#import "ShoppingList/Constants.h"

// ShoppingList model's constants

NSString *kShoppingListEntity = @"ShoppingList";
NSString *kShoppingListClass = @"ShoppingList";
NSString *kShoppingListName = @"name";
NSString *kShoppingListLastModificationDate = @"lastModificationDate";
NSString *kShoppingListOrder = @"order";
NSString *kShoppingListItems = @"items";

// ShoppingItem model's constants

NSString *kShoppingItemEntity = @"ShoppingItem";
NSString *kShoppingItemClass = @"ShoppingItem";
NSString *kShoppingItemName = @"name";
NSString *kShoppingItemQuantity = @"quantity";
NSString *kShoppingItemOrder = @"order";
NSString *kShoppingItemList = @"list";

// ShoppingListController's constants

// Administration of shopping lists
NSString *kShoppingListTitle = @"Mis listas";
// NSLocalizedString(@"Mis listas", nil)
// Fetch-request controller cache's file name
NSString *kShoppingListCacheName = @"ShoppingListController.cache";
// Default detail text
extern NSString *kDefaultDetailText = @"Nuevo";
// NSLocalizedString(@"Nuevo", nil)

// InputView's constants for shopping list creation
NSString *kShoppingListNewTitle = @"Nueva lista";
// NSLocalizedString(@"Nueva lista", nil)
NSString *kShoppingListNewMessage = @"Ingrese el nombre de la nueva lista de " 
        @"compras";
// NSLocalizedString(@"Ingrese el nombre de la nueva lista de "
//      @"compras", nil)
NSString *kShoppingListNewOkButtonTitle = @"Ok";
// NSLocalizedString(@"Ok", nil)
NSString *kShoppingListNewCancelButtonTitle = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)
