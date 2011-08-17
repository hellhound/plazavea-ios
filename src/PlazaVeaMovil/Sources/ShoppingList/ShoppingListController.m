#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Additions/NSNull+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingItemAlertView.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"
#import "ShoppingList/HistoryEntryController.h"
#import "ShoppingList/ShoppingListController.h"

static NSPredicate *kShoppingItemsPredicateTemplate;
static NSString *kShoppingListVariableKey = @"SHOPPING_LIST";

@interface ShoppingListController (Private)

+ (void)initializePredicateTemplates;

- (void)showAlertViewForNewShoppingList:(TSAlertView *)alertView;
- (void)showAlertViewForNewShoppingItem:(TSAlertView *)alertView;
- (void)updatePreviousNextButtons;
@end

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [ShoppingListController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    _delegate = nil;
    [_shoppingList release];
    [_previousItem release];
    [_nextItem release];
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
        // Conf the back button
        _previousItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                target:self action:@selector(previousList:)];
        // Conf the rewind button
        _nextItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                target:self action:@selector(nextList:)];
        // Conf a spacer
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];
        // Conf the add button
        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                target:self action:@selector(addItemHandler:)] autorelease];
        // Conf the action button
        UIBarButtonItem *actionItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                target:self action:@selector(displayActionSheet:)] autorelease];
        // Conf the rewind trash button
        UIBarButtonItem *trashItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                target:self action:@selector(deleteList:)] autorelease];

        [[self readonlyToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:_previousItem, spacerItem, addItem,
                    spacerItem, actionItem, spacerItem, trashItem, spacerItem,
                    _nextItem, nil]];
        [[self editingToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:spacerItem, addItem, spacerItem,
                    spacerItem, trashItem, nil]];
        [self setToolbarItems:[self readonlyToolbarItems]];
        [[self navigationController] setToolbarHidden:NO];
    [self updatePreviousNextButtons];
    }
    return navItem;
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    [[cell textLabel] setText:[(ShoppingItem *)object name]];
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

- (void)didChangeObject:(ShoppingItem *)item value:(NSString *)value
{
    [item setName:value];
}

#pragma mark -
#pragma mark ShoppingListController (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs = [NSExpression expressionForKeyPath:kShoppingItemList];
    NSExpression *rhs =
            [NSExpression expressionForVariable:kShoppingListVariableKey];

    kShoppingItemsPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSEqualToPredicateOperatorType
            options:0] retain];
}

- (void)showAlertViewForNewShoppingList:(TSAlertView *)alertView
{
    [alertView show];
    [alertView autorelease];
}

- (void)showAlertViewForNewShoppingItem:(TSAlertView *)alertView
{
    [alertView show];
    [alertView autorelease];
}

- (void)repairViewControllerList
{
    UINavigationController *navController = [self navigationController];

    [navController setViewControllers:[NSArray arrayWithObjects:
            [[navController viewControllers] objectAtIndex:0], self, nil]];
}

- (void)updatePreviousNextButtons
{
    [_previousItem setEnabled:[_shoppingList previous] != nil];
    [_nextItem setEnabled:[_shoppingList next] != nil];
}

#pragma mark -
#pragma mark ShoppingListController (Public)

@synthesize delegate = _delegate, shoppingList = _shoppingList;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList
{
    return [kShoppingItemsPredicateTemplate predicateWithSubstitutionVariables:
        [NSDictionary dictionaryWithObject:[NSNull nullOrObject:shoppingList]
            forKey:kShoppingListVariableKey]];
}

- (id)initWithShoppingList:(ShoppingList *)shoppingList
                  delegate:(id)delegate
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kOrderField
                ascending:NO] autorelease]];
    NSPredicate *predicate =
            [ShoppingListController predicateForItemsWithShoppingList:
                shoppingList];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingItemEntity predicate:predicate
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setDelegate:delegate];
        [self setAllowsMovableCells:YES];
        [self setShoppingList:shoppingList];
        if (shoppingList == nil) {
            // We need to create a brand-new shopping list!
            TSAlertView *alertView =
                [[TSAlertView alertViewForNewShoppingList:self] retain];

            // delay for 0.1 seconds
            [self performSelector:@selector(showAlertViewForNewShoppingList:)
                    withObject:alertView
                    afterDelay:kShoppingListAlertViewDelay];
        }
    }
    return self;
}

- (void)setShoppingList:(ShoppingList *)shoppingList
{
    if (_shoppingList != shoppingList) {
        [_shoppingList autorelease];
        _shoppingList = [shoppingList retain];
        [self setTitle:[shoppingList name]];
    }
}

- (void)addShoppingList:(NSString *)name
{
    if ([_delegate respondsToSelector:
            @selector(shoppingListController:didAddShoppingListWithName:)]) {
        ShoppingList *list = [_delegate shoppingListController:self
                didAddShoppingListWithName:name];
        // This should take care of the title refreshing
        [self setShoppingList:list];

        // Now, create a new predicate for the new shopping list
        NSPredicate *predicate =
                [ShoppingListController predicateForItemsWithShoppingList:
                    _shoppingList];

        // And lastly, set the predicate to the fetch request of the results
        // controller 
        [[[self resultsController] fetchRequest] setPredicate:predicate];
        [self updatePreviousNextButtons];
    }
}

- (void)addShoppingItem:(NSString *)name quantity:(NSString *)quantity
{
    [ShoppingHistoryEntry historyEntryWithName:name context:[self context]];
    [ShoppingItem shoppingItemWithName:name quantity:quantity
            list:[self shoppingList]
            resultsController:[self resultsController]];

    // First, save the context
    [self saveContext];
    [self fetchUpdateAndReload];
}

#pragma mark -
#pragma mark ShoppingListController (EventHandler)

- (void)previousList:(UIControl *)control
{
    ShoppingList *previousList = [_shoppingList previous];

    [self setShoppingList:previousList];
    [[[self resultsController] fetchRequest] setPredicate:
            [ShoppingListController predicateForItemsWithShoppingList:
                previousList]];
    [self fetchUpdateAndReload];
    [self updatePreviousNextButtons];
}

- (void)nextList:(UIControl *)control
{
    ShoppingList *nextList = [_shoppingList next];

    [self setShoppingList:[_shoppingList next]];
    [[[self resultsController] fetchRequest] setPredicate:
            [ShoppingListController predicateForItemsWithShoppingList:
                nextList]];
    [self fetchUpdateAndReload];
    [self updatePreviousNextButtons];
}

- (void)addItemHandler:(UIControl *)control
{
    [[self navigationController] pushViewController:
            [[[HistoryEntryController alloc]
                initWithDelegate:self] autorelease] animated:YES];
}

- (void)deleteList:(UIControl *)control
{
    [[self context] deleteObject:_shoppingList];
    [self saveContext];
    if ([_delegate respondsToSelector:
            @selector(shoppingListController:didDeleteShoppingList:)])
        [_delegate shoppingListController:self
                didDeleteShoppingList:_shoppingList];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)displayActionSheet:(UIControl *)control
{
}

#pragma mark -
#pragma mark <HistoryEntryControllerDelegate>

- (void)historyEntryController:(HistoryEntryController *)historyEntryController
                  historyEntry:(ShoppingHistoryEntry *)historyEntry
{
    // We need to create a brand-new item for this list!
    TSAlertView *alertView =
            [[TSAlertView alertViewForNewShoppingItem:self] retain];

    // delay for 0.1 seconds
    [self performSelector:@selector(showAlertViewForNewShoppingItem:)
            withObject:alertView afterDelay:kShoppingListAlertViewDelay];
}
@end
