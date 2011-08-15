#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/HistoryEntryController.h"

@interface HistoryEntryController (Private)
@end

@implementation HistoryEntryController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    return [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingHistoryEntryEntity predicate:nil
            sortDescriptors:nil inContext:context];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // TODO We should use titleView instead of title in the navigationItem
    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        // Conf a spacer
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];
        // Conf the add button
        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                target:nil action:NULL] autorelease];

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
#pragma mark EditableCellTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    [[cell textLabel] setText:[(ShoppingHistoryEntry *)object name]];
}

- (void)didChangeObject:(ShoppingHistoryEntry *)item value:(NSString *)value
{
    [item setName:value];
}

#pragma mark -
#pragma mark HistoryEntryController (Private)

#pragma mark -
#pragma mark HistoryEntryController (Public)

+ (NSPredicate *)predicateForItemsLikeName:(NSString *)name
{
    return nil;
}

#pragma mark -
#pragma mark HistoryEntryController (EventHandler)

@end
