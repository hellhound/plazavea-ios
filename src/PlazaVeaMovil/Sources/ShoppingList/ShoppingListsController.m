#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Constants.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/EditableTableViewController+NewShoppingListAlertView.h"
#import "ShoppingList/ShoppingListController.h"
#import "ShoppingList/ShoppingListsController.h"

@implementation ShoppingListsController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kShoppingListOrder
                ascending:NO] autorelease]];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingListEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setCellStyle:UITableViewCellStyleSubtitle];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // TODO We should use titleView instead of title in the navigationItem
    // Conf the title
    [navItem setTitle:NSLocalizedString(kShoppingListTitle, nil)];

    UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:NULL] autorelease];
    // Conf the add-item button
    UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
            target:self action:@selector(addShoppingListHandler:)] autorelease];

    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        NSArray *toolbarItems =
                [NSArray arrayWithObjects:spacerItem, addItem, nil];

        [[self readonlyToolbarItems] addObjectsFromArray:toolbarItems];
        [[self editingToolbarItems] addObjectsFromArray:toolbarItems];
        [self setToolbarItems:[self readonlyToolbarItems]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (void)didSelectRowForObject:(NSManagedObject *)object
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing])
        [[self navigationController] pushViewController:
                    [[[ShoppingListController alloc] initWithShoppingList:
                            (ShoppingList *)object] autorelease]
                animated:YES];
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    ShoppingList *list = (ShoppingList *)object;
    NSDateFormatter *dateFormatter = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter];
    NSDate *date = [list lastModificationDate];

    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    [[cell textLabel] setText:[list name]];
    [[cell detailTextLabel] setText:date == nil ||
            [date isEqual:[NSNull null]] ?
            kShoppingListDefaultDetailText :
            [dateFormatter stringFromDate:date]];
}

- (void)didChangeObject:(ShoppingList *)object value:(NSString *)value
{
    ShoppingList *list = object;

    [list setName:value];
}

#pragma mark -
#pragma mark ShoppingListsController (Public)

- (void)addShoppingList:(NSString *)name
{
    ShoppingList *newList =
            [NSEntityDescription insertNewObjectForEntityForName:
                kShoppingListEntity
            inManagedObjectContext:[self context]];
    NSInteger order = [(NSNumber *)[[_resultsController fetchedObjects]
            valueForKeyPath:@"@max.order"] integerValue] + 1;

    [newList setName:name];
    [newList setOrder:[NSNumber numberWithInteger:order]];
    [self saveContext];
    [self fetchUpdateAndReload];
}

- (void)changeName:(NSString *)name toShoppingList:(ShoppingList *)shoppingList
{
    [shoppingList setName:name];
    [self fetchUpdateAndReload];
}

#pragma mark -
#pragma mark ShoppingListsController (EnventHandler)

- (void)addShoppingListHandler:(UIControl *)control
{
    if ([self isEditing]) {
        TSAlertView *alertView = [self alertViewForNewShoppingList];

        [alertView show];
    } else {
        [[self navigationController] pushViewController:
                    [[[ShoppingListController alloc] init] autorelease]
                animated:YES];
    }
}
@end
