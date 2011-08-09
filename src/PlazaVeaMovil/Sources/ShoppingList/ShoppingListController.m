#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/EditableTableViewController+NewShoppingListAlertView.h"
#import "ShoppingList/ShoppingListController.h"

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    // It is used only when necessary to show an alert view the user for a name
    // for the new shopping list
    if ((self = [super init]) != nil) {
        TSAlertView *alertView = [self alertViewForNewShoppingList];

        // delay for 0.1 seconds
        [alertView performSelector:@selector(show) withObject:nil
                afterDelay:kNewShoppingListAlertViewDelay];
    }
    return self;
}

- (void)dealloc
{
    [_shoppingList release];
    [super dealloc];
}

#pragma mark -
#pragma mark ShoppingListController (Public)

- (id)initWithShoppingList:(ShoppingList *)shoppingList
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kShoppingListOrder
                ascending:NO] autorelease]];
    NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"list == %@", shoppingList];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingItemEntity predicate:predicate
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setAllowsMovableCells:YES];
    }
    return self;
}

#pragma mark -
#pragma mark ShoppingListController (EventHandler)

- (void)addShoppingListHandler:(UIControl *)control
{
}

- (void)addShoppingItemHandler:(UIControl *)control
{
}
@end
