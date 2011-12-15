#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Constants.h"
#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
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
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:
            kShoppingHistoryEntryName ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingListEntity predicate:nil
                sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kShoppingListTitle, nil)];
        [self setAllowsMovableCells:YES];
        [self setCellStyle:UITableViewCellStyleSubtitle];
    }
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                    target:nil action:NULL] autorelease];
        // Conf the add-item button
        UIButton *addButton;

        if ([TTStyleSheet 
                hasStyleSheetForSelector:
                    @selector(shopingListButtonAdd)])
            addButton = (UIButton *)TTSTYLE(shopingListButtonAdd);
        [addButton addTarget:self action:@selector(addShoppingListHandler:)
                forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithCustomView:addButton] autorelease];
        NSArray *toolbarItems =
                [NSArray arrayWithObjects:spacerItem, addItem, nil];

        [[self readonlyToolbarItems] addObjectsFromArray:toolbarItems];
        [[self editingToolbarItems] addObjectsFromArray:toolbarItems];
        [self setToolbarItems:[self readonlyToolbarItems]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

- (void)loadView
{
    [super loadView];
    CGRect bounds = [[self tableView] bounds];
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0,
            bounds.size.width, 40.)] autorelease];

    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(shopingListBackgroundHeader)]){
        UIImageView *backgroundView = [[[UIImageView alloc] 
                initWithImage:(UIImage *)TTSTYLE(shopingListBackgroundHeader)]
                autorelease];

        [headerView setClipsToBounds:YES];
        [headerView addSubview:backgroundView];
        [headerView sendSubviewToBack:backgroundView];
    }

    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10., 10.,
            bounds.size.width, 20.)] autorelease];

    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setNumberOfLines:1];
    [titleLabel setMinimumFontSize:10];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:NSLocalizedString(kShoppingListTitle, nil)];

    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(headerColorYellow)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];

    [headerView addSubview:titleLabel];
    [[self tableView] setTableHeaderView:headerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
                        delegate:self] autorelease]
                animated:YES];
}

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    ShoppingList *list = (ShoppingList *)object;
    //NSDateFormatter *dateFormatter = [(AppDelegate *)
    //        [[UIApplication sharedApplication] delegate] dateFormatter];
    //NSDate *date = [list lastModificationDate];

    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:[list name]];
    //[[cell detailTextLabel] setText:date == nil ||
    //        [date isEqual:[NSNull null]] ?
    //        kShoppingListDefaultDetailText :
    //        [dateFormatter stringFromDate:date]];
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

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

#pragma mark -
#pragma mark ShoppingListsController (EnventHandler)

- (void)addShoppingListHandler:(UIControl *)control
{
    if ([self isEditing]) {
        TSAlertView *alertView = [TSAlertView alertViewForNewShoppingList:self
                fromActionSheet:NO];

        [alertView show];
    } else {
        [[self navigationController]
                pushViewController:[[[ShoppingListController alloc]
                    initWithShoppingList:nil
                    delegate:self] autorelease] animated:YES];
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

- (void)shoppingListController:(ShoppingListController *)shoppingListController
         didDeleteShoppingList:(ShoppingList *)shoppingList
{
    [self fetchUpdateAndReload];
}

- (void)shoppingListController:(ShoppingListController *)shoppingListController
          didCloneShoppingList:(ShoppingList *)shoppingList
{
    [shoppingList setName:[ShoppingList resolveNewNameFromName:[
            shoppingList name]]];
    [self fetchUpdateAndReload];
}
@end
