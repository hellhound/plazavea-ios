#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/HistoryEntryController.h"

@interface HistoryEntryController ()

// @private
@property (nonatomic, retain) UISearchDisplayController *searchController;
@end

@implementation HistoryEntryController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
            [NSSortDescriptor sortDescriptorWithKey:kShoppingHistoryEntryName
                ascending:YES],
            nil];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingHistoryEntryEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
             [self setTitle:NSLocalizedString(kHistoryEntryTitle, nil)];
    }
    return self;
}

- (void)dealloc
{
    [_filteredResultsController release];
    [_searchController release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Setup searchBar and searchDisplayController
    
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    [searchBar sizeToFit];
    [searchBar setDelegate:self];
    // When initWithSearchBar:contentsController: is sent to an instance of
    // UISearchDisplayController, the UIViewController automatically sets its
    // searchDisplayerController to this instance but it doesn't retains it.
    // This leads to unwanted behavior, so to correct this, we retain/release
    // this instance within the scope of this class, that is, maintaining
    // ownership of the instance with the searchController property.
    [self setSearchController:
            [[[UISearchDisplayController alloc] initWithSearchBar:searchBar
                contentsController:self] autorelease]];
    [_searchController setDelegate:self];
    [_searchController setSearchResultsDataSource:self];
    [_searchController setSearchResultsDelegate:self];
    [[self tableView] setTableHeaderView:searchBar];
}

- (void)viewDidUnload
{
    // release and set it to nil
    [self setSearchController:nil];
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

@synthesize filteredResultsController = _filteredResultsController,
    searchController = _searchController;

+ (NSPredicate *)predicateForItemsLikeName:(NSString *)name
{
    return nil;
}

#pragma mark -
#pragma mark HistoryEntryController (EventHandler)

#pragma mark -
#pragma mark HistoryEntryController <UISearchBarDelegate>

#pragma mark -
#pragma mark HistoryEntryController <UISearchDisplayDelegate>

@end
