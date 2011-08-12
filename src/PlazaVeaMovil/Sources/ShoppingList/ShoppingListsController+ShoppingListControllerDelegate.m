#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListController.h"
#import "ShoppingList/ShoppingListsController.h"

@interface ShoppingListsController (ShoppingListControllerDelegate)
@end

@implementation ShoppingListsController (ShoppingListControllerDelegate)

#pragma mark -
#pragma mark <ShoppingListControllerDelegate>

- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name
{
    ShoppingList *list = [ShoppingList shoppingListWithName:name
        resultsController:[self resultsController]];

    // First, save the context
    [self saveContext];
    [self fetchUpdateAndReload];
    return list;
}
@end
