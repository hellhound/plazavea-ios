#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Constants.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"
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
            [[[NSSortDescriptor alloc] initWithKey:kOrderField
                ascending:NO] autorelease]];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingListEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kShoppingListTitle, nil)];
        [self setAllowsMovableCells:YES];
        [self setCellStyle:UITableViewCellStyleSubtitle];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // TODO We should use titleView instead of title in the navigationItem
    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];
        // Conf the add-item button
        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                target:self action:
                    @selector(addShoppingListHandler:)] autorelease];
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

- (void)didSelectRowForObject:(ShoppingList *)shoppingList
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing])
        [[self navigationController]
                pushViewController:
                    [[[ShoppingListController alloc]
                        initWithShoppingList:shoppingList
                        delegateForAdding:self] autorelease]
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

- (void)didChangeObject:(ShoppingList *)list value:(NSString *)value
{
    [list setName:value];
}

#pragma mark -
#pragma mark ShoppingListsController (Public)

- (void)addShoppingList:(NSString *)name
{
    [ShoppingList shoppingListWithName:name
            resultsController:[self resultsController]];
    [self fetchUpdateAndReload];
    [self scrollToTop];
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
        TSAlertView *alertView = [TSAlertView alertViewForNewShoppingList:self];

        [alertView show];
    } else {
        [[self navigationController]
                pushViewController:[[[ShoppingListController alloc]
                    initWithShoppingList:nil
                    delegateForAdding:self] autorelease] animated:YES];
    }
}

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
