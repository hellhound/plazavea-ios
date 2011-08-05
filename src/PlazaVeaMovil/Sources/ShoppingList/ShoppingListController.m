#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Views/InputView.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListController.h"

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kShoppingListOrder
                ascending:NO] autorelease]];

    return [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingListEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context];
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

    // Conf the toolbar
    [self setToolbarItems:[NSArray arrayWithObjects:
            [self undoItem], [self redoItem], spacerItem, addItem, nil]];
    return navItem;
}

#pragma mark -
#pragma mark ShoppingListController (Public)

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
    [self fetchUpdateAndReload];
}

- (void)changeName:(NSString *)name toShoppingList:(ShoppingList *)shoppingList
{
    [shoppingList setName:name];
    [self fetchUpdateAndReload];
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(UITableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    ShoppingList *list = (ShoppingList *)object;
    NSDateFormatter *dateFormatter = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter];
    NSDate *date = [list lastModificationDate];

    if (cell == nil)
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:reuseIdentifier] autorelease];
    [[cell textLabel] setText:[list name]];
    [[cell detailTextLabel] setText:date == nil ||
            [date isEqual:[NSNull null]] ?
            kShoppingListDefaultDetailText :
            [dateFormatter stringFromDate:date]];
    return cell;
}

- (void)didSelectRowForObject:(NSManagedObject *)object
                  atIndexPath:(NSIndexPath *)indexPath
{
    if ([self isEditing])
        [self changeShoppingListNameHandler:object];
}

#pragma mark -
#pragma mark ShoppingListController (EnventHandler)

- (void)addShoppingListHandler:(UIControl *)control
{
    InputView *inputView =
            [[[InputView alloc] initWithTitle:
                    NSLocalizedString(kShoppingListNewTitle, nil)
                message:NSLocalizedString(kShoppingListNewMessage, nil)
                delegate:self cancelButtonTitle:
                    NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
                otherButtonTitles:
                    NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                     nil] autorelease];

    [inputView setTag:kShoppingListCreationTag];
    [inputView show];
}

- (void)changeShoppingListNameHandler:(ShoppingList *)shoppingList
{
    InputView *inputView =
            [[[InputView alloc] initWithTitle:
                    NSLocalizedString(kShoppingListNewTitle, nil)
                message:NSLocalizedString(kShoppingListNewMessage, nil)
                delegate:self cancelButtonTitle:
                    NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
                otherButtonTitles:
                    NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                     nil] autorelease];

    [inputView setInitialText:[shoppingList name]];
    [inputView setTag:kShoppingListModificationTag];
    [[inputView userInfo] setObject:shoppingList forKey:kShoppingListKey];
    [inputView show];
}
@end
