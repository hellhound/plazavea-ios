#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListController.h"

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

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
@end
