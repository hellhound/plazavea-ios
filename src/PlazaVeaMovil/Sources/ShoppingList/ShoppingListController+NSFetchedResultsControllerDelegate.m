#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (NSFetchedResultsControllerDelegate)
@end

@implementation ShoppingListController (NSFetchedResultsControllerDelegate)

#pragma mark -
#pragma mark <NSFetchedResultsControllerDelegate>

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // NO-OP. This empty method is intentional. Implementing any delegate method
    // triggers the change-tracking functionality of the fetch-request
    // controller;
}
@end
