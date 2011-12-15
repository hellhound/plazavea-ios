#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MessageUI.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Controllers/EditableTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"
#import "ShoppingList/TSAlertView+NewShoppingItemAlertView.h"
#import "ShoppingList/TSAlertView+ModifyingShoppingItemAlertView.h"
#import "ShoppingList/TSAlertView+ShoppingListDeletionConfirmation.h"
#import "ShoppingList/UIActionSheet+ShoppingListMenu.h"
#import "ShoppingList/HistoryEntryController.h"
#import "ShoppingList/ShoppingListController.h"

static NSPredicate *kShoppingItemsPredicateTemplate;
static NSString *const kShoppingListVariableKey = @"SHOPPING_LIST";
static const NSInteger kListNameLabelTag = 100;
static const NSInteger kListDateLabelTag = 101;

@interface ShoppingListController (Private)

+ (void)initializePredicateTemplates;

- (void)updatePreviousNextButtons;
- (void)showAlertViewForNewShoppingList:(TSAlertView *)alertView;
- (void)showAlertViewForNewShoppingItem:(TSAlertView *)alertView;
- (void)showAlertViewForShoppingListDeletion:(TSAlertView *)alertView;
- (void)initializeHeader;
- (void)updateHeader;
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
                target:self action:@selector(addItem:)] autorelease];
        // Conf the action button
        UIBarButtonItem *actionItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                target:self action:@selector(displayActionSheet:)] autorelease];
        // Conf the rewind trash button
        UIBarButtonItem *trashItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                target:self action:@selector(delete:)] autorelease];

        [[self readonlyToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:_previousItem, spacerItem, addItem,
                    spacerItem, actionItem, spacerItem, trashItem, spacerItem,
                    _nextItem, nil]];
        [[self editingToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:spacerItem, addItem, spacerItem,
                    spacerItem, trashItem, nil]];
        [self setToolbarItems:[self readonlyToolbarItems]];
        [[self navigationController] setToolbarHidden:NO];
        if ([TTStyleSheet 
                hasStyleSheetForSelector:@selector(navigationBackgroundColor)])
            [[[self navigationController] toolbar]
                    setTintColor:(UIColor *)TTSTYLE(navigationBackgroundColor)];
        [self updatePreviousNextButtons];
    }
    return navItem;
}
   
#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(ShoppingItem *)item
          atIndexPath:(NSIndexPath *)indexPath
{
    [[cell textLabel] setText:[item serialize]];
    [cell setAccessoryType:[[item checked] boolValue] ?
            UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone];
}

- (void)didSelectRowForObject:(ShoppingItem *)item
                  atIndexPath:(NSIndexPath *)indexPath
{
    if ([self isEditing]) {
        TSAlertView *alertView =
                [TSAlertView alertViewForModifyingShoppingItem:self
                    shoppingItem:item];

        [alertView show];
    } else {
        UITableViewCell *cell =
                [[self tableView] cellForRowAtIndexPath:indexPath];
        ShoppingItem *item =
                [[self resultsController] objectAtIndexPath:indexPath];

        if ([cell accessoryType] == UITableViewCellAccessoryNone) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [item setChecked:[NSNumber numberWithBool:YES]];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [item setChecked:[NSNumber numberWithBool:NO]];
        }
        [self saveContext];
    }
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

- (void)updatePreviousNextButtons
{
    [_previousItem setEnabled:[_shoppingList previous] != nil];
    [_nextItem setEnabled:[_shoppingList next] != nil];
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

- (void)showAlertViewForShoppingListDeletion:(TSAlertView *)alertView
{
    [alertView show];
    [alertView autorelease];
}

- (void)initializeHeader
{
    UITableView *tableView = [self tableView];
    CGRect bounds = [tableView bounds];
    
    UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10., 10.,
            (bounds.size.width - 150.), 20.)] autorelease];
    
    [nameLabel setAdjustsFontSizeToFitWidth:YES];
    [nameLabel setNumberOfLines:1];
    [nameLabel setMinimumFontSize:10];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setText:[_shoppingList name]];
    [nameLabel setTag:kListNameLabelTag];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [nameLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(headerColorYellow)])
        [nameLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    
    NSDateFormatter *dateFormatter = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter];
    UILabel *dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10,
            10., (bounds.size.width - 10), 20.)] autorelease];
    
    [dateLabel setAdjustsFontSizeToFitWidth:YES];
    [dateLabel setTextAlignment:UITextAlignmentRight];
    [dateLabel setNumberOfLines:1];
    [dateLabel setMinimumFontSize:10];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [dateLabel setTag:kListDateLabelTag];
    [dateLabel setText:[dateFormatter stringFromDate:[_shoppingList
            lastModificationDate]]];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(tableTextFont)])
        [dateLabel setFont:(UIFont *)TTSTYLE(tableTextFont)];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(headerColorYellow)])
        [dateLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0,
            bounds.size.width, 40.)] autorelease];
    
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(shopingListBackgroundHeader)]){
        UIImageView *backgroundView = [[[UIImageView alloc] 
                initWithImage:(UIImage *)TTSTYLE(shopingListBackgroundHeader)]
                autorelease];

        [headerView addSubview:backgroundView];
        [headerView sendSubviewToBack:backgroundView];
    }
    [headerView addSubview:nameLabel];
    [headerView addSubview:dateLabel];
    [tableView setTableHeaderView:headerView];
}

- (void)updateHeader
{
    UILabel *listNameLabel = (UILabel *)[[[self tableView] tableHeaderView]
            viewWithTag:kListNameLabelTag];
    
    if (listNameLabel != nil)
        [listNameLabel setText:[_shoppingList name]];
    
    UILabel *listDateLabel = (UILabel *)[[[self tableView] tableHeaderView]
            viewWithTag:kListDateLabelTag];
    
    if (listDateLabel != nil) {
        NSDateFormatter *dateFormatter = [(AppDelegate *)
                [[UIApplication sharedApplication] delegate] dateFormatter];
        
        [listDateLabel setText:[dateFormatter stringFromDate:[_shoppingList
                lastModificationDate]]];
    }

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
        [self setAllowsRowDeselectionOnEditing:YES];
        [self setShoppingList:shoppingList];
        if (shoppingList == nil) {
            [self createNewShoppingListFromActionSheet:NO];
        } else {
            [self initializeHeader];
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

- (void)modifyShoppingItem:(ShoppingItem *)shoppingItem
                      name:(NSString *)name
                  quantity:(NSString *)quantity
{
    [ShoppingHistoryEntry historyEntryWithName:name context:[self context]];

    [shoppingItem setName:name];
    [shoppingItem setQuantity:quantity];
    // First, save the context
    [self saveContext];
    [self fetchUpdateAndReload];
}

- (void)deleteShoppingList
{
    [[self context] deleteObject:_shoppingList];
    [self saveContext];
    if ([_delegate respondsToSelector:
            @selector(shoppingListController:didDeleteShoppingList:)])
        [_delegate shoppingListController:self
                didDeleteShoppingList:_shoppingList];
    [[self navigationController] popToViewController:_delegate animated:YES];
}

- (void)createNewShoppingListFromActionSheet:(BOOL)fromActionSheet
{
    // We need to create a brand-new shopping list!
    TSAlertView *alertView = [[TSAlertView alertViewForNewShoppingList:self
            fromActionSheet:fromActionSheet] retain];

    // delay for 0.1 seconds
    [self performSelector:@selector(showAlertViewForNewShoppingList:)
            withObject:alertView
            afterDelay:kShoppingListAlertViewDelay];
}

#pragma mark -
#pragma mark ShoppingListController (EventHandler)

- (void)addShoppingList:(NSString *)name fromActionSheet:(BOOL)fromActionSheet
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
        if (fromActionSheet) {
            [self fetchUpdateAndReload];
        } else {
            [self initializeHeader];
        }
        [self updatePreviousNextButtons];
    }
}

- (void)previousList:(UIControl *)control
{
    ShoppingList *previousList = [_shoppingList previous];

    [self setShoppingList:previousList];
    [[[self resultsController] fetchRequest] setPredicate:
            [ShoppingListController predicateForItemsWithShoppingList:
                previousList]];
    [self fetchUpdateAndReload];
    [self updateHeader];
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
    [self updateHeader];
    [self updatePreviousNextButtons];
}

- (void)addItem:(UIControl *)control
{
    [[self navigationController] pushViewController:
            [[(HistoryEntryController *)[HistoryEntryController alloc]
                initWithDelegate:self] autorelease] animated:YES];
}

- (void)delete:(UIControl *)control
{
    // We need confirmation from the user
    TSAlertView *alertView =
            [[TSAlertView alertViewForShoppingListDeletion:self] retain];

    // delay for 0.1 seconds
    [self performSelector:@selector(showAlertViewForShoppingListDeletion:)
            withObject:alertView
            afterDelay:kShoppingListAlertViewDelay];
}

- (void)displayActionSheet:(UIControl *)control
{
    UIActionSheet *actionSheet =
            [UIActionSheet actionSheetForShoppingListMenu:self];

    [actionSheet showFromToolbar:[[self navigationController] toolbar]];
}

- (void)cloneShoppingList
{
    ShoppingList *clonedList =
            [ShoppingList shoppingListWithName:[_shoppingList name]
                context:[self context]];

    for (ShoppingItem *item in [_shoppingList items]) {
        ShoppingItem *clonedItem =
                [ShoppingItem shoppingItemWithName:[item name]
                    quantity:[item quantity] list:clonedList
                    context:[self context]];

        [clonedItem setOrder:[item order]];
        [clonedItem setChecked:[item checked]];
    }
    [self updatePreviousNextButtons];
    [self fetchUpdateAndReload];
    if ([_delegate respondsToSelector:
            @selector(shoppingListController:didCloneShoppingList:)])
        [_delegate shoppingListController:self
                didCloneShoppingList:clonedList];
    [self saveContext];
}

- (void)mailShoppingList
{
    MFMailComposeViewController *picker = 
            [[[MFMailComposeViewController alloc] init] autorelease];

    [picker setMailComposeDelegate:self];
    [picker setSubject:[_shoppingList name]];
    [picker setMessageBody:[_shoppingList serialize] isHTML:NO];
    [self presentModalViewController:picker animated:YES];
}

#pragma mark -
#pragma mark <HistoryEntryControllerDelegate>

- (void)historyEntryController:(HistoryEntryController *)historyEntryController
                  historyEntry:(ShoppingHistoryEntry *)historyEntry
                      withText:(NSString *)productText
{
    // We need to create a brand-new item for this list!
    TSAlertView *alertView = [[TSAlertView alertViewForNewShoppingItem:self
            historyEntry:historyEntry withText:productText] retain];

    // delay for 0.1 seconds
    [self performSelector:@selector(showAlertViewForNewShoppingItem:)
            withObject:alertView afterDelay:kShoppingListAlertViewDelay];
}
@end
