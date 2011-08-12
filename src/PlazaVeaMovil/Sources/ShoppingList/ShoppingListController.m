#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"
#import "ShoppingList/ShoppingListsController.h"
#import "ShoppingList/ShoppingListController.h"

static NSPredicate *kShoppingItemsPredicateTemplate;
static NSString *kShoppingListVariableKey = @"SHOPPING_LIST";

@interface ShoppingListController ()

@property (nonatomic, retain) id delegate;

- (void)showAlertViewForNewShoppingList:(TSAlertView *)alertView;
@end

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [ShoppingListController class]) {
        NSExpression *lhs =
                [NSExpression expressionForKeyPath:kShoppingItemList];
        NSExpression *rhs =
                [NSExpression expressionForVariable:kShoppingListVariableKey];

        kShoppingItemsPredicateTemplate = [[NSComparisonPredicate
                predicateWithLeftExpression:lhs
                rightExpression:rhs
                modifier:NSDirectPredicateModifier
                type:NSEqualToPredicateOperatorType
                options:0] retain];
    }
}

- (void)dealloc
{
    _delegate = nil;
    [_shoppingList release];
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
        // Conf the back button
        UIBarButtonItem *backItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                target:nil action:NULL] autorelease];
        // Conf the add button
        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                target:nil action:NULL] autorelease];
        // Conf the action button
        UIBarButtonItem *actionItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                target:nil action:NULL] autorelease];
        // Conf the rewind trash button
        UIBarButtonItem *trashItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                target:nil action:NULL] autorelease];
        // Conf the rewind button
        UIBarButtonItem *forwardItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                target:nil action:NULL] autorelease];

        [[self readonlyToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:backItem, spacerItem, addItem,
                    spacerItem, actionItem, spacerItem, trashItem, spacerItem,
                    forwardItem, nil]];
        [[self editingToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:spacerItem, addItem, spacerItem,
                    spacerItem, trashItem, nil]];
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
    [[cell textLabel] setText:[(ShoppingItem *)object name]];
}

- (void)didChangeObject:(ShoppingItem *)item value:(NSString *)value
{
    [item setName:value];
}

#pragma mark -
#pragma mark ShoppingListController (Private)

@synthesize delegate = _delegate;

- (void)showAlertViewForNewShoppingList:(TSAlertView *)alertView
{
    [alertView show];
    [alertView autorelease];
}

#pragma mark -
#pragma mark ShoppingListController (Public)

@synthesize shoppingList = _shoppingList;

+ (NSPredicate *)predicateForItemsWithShoppingList:(ShoppingList *)shoppingList
{
    return [kShoppingItemsPredicateTemplate predicateWithSubstitutionVariables:
            [NSDictionary dictionaryWithObject:shoppingList == nil ?
                    (id)[NSNull null] : (id)shoppingList
                forKey:kShoppingListVariableKey]];
}

- (id)initWithShoppingList:(ShoppingList *)shoppingList delegate:(id)delegate
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
                    afterDelay:kNewShoppingListAlertViewDelay];
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
