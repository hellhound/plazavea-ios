#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Additions/NSError+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListController.h"
#import "ShoppingList/HistoryEntryController.h"

static NSPredicate *kEntriesPredicateTemplate;
static NSString *kNameVariableKey = @"NAME";

@interface HistoryEntryController ()

// @private
@property (nonatomic, readonly)
    NSFetchedResultsController *filteredController;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, assign) BOOL noLists;

+ (void)initializePredicateTemplates;
@end

@implementation HistoryEntryController

@synthesize noLists;

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [HistoryEntryController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    _delegate = nil;
    [_filteredController setDelegate:nil];
    [_filteredController release];
    [_searchController setDelegate:nil];
    [_searchController release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        // Conf a spacer
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];
        // Conf the add button
        UIButton *addButton;
        
        if ([TTStyleSheet
             hasStyleSheetForSelector:@selector(barButtonAddIcon)]) {
            UIImage *plusSign = (UIImage *)TTSTYLE(barButtonAddIcon);
            addButton = [[[UIButton alloc] initWithFrame:
                    CGRectMake(.0, .0, plusSign.size.width,
                        plusSign.size.height)] autorelease];
            
            [addButton setImage:plusSign forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(addHistoryEntry:)
                    forControlEvents:UIControlEventTouchUpInside];
        }
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

- (void)viewDidLoad
{
    noLists = YES;
    [super viewDidLoad];
    // Setup searchBar and searchDisplayController
    
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(shoppingListsSearchBarColor)]) {
        [searchBar setTintColor:
                (UIColor *)TTSTYLE(shoppingListsSearchBarColor)];
    }
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
#pragma mark EditableTableViewController (Overridable)

- (void)didSelectRowForObject:(ShoppingHistoryEntry *)historyEntry
                  atIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:
            @selector(historyEntryController:historyEntry:withText:)])
        [_delegate historyEntryController:self historyEntry:historyEntry
                withText:nil];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didCreateCell:(UITableViewCell *)cell
            forObject:(ShoppingHistoryEntry *)historyEntry
          atIndexPath:(NSIndexPath *)indexPath
{
    [[cell textLabel] setText:[historyEntry name]];
    [[cell textLabel] setNumberOfLines:0];
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:18.]];
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

- (void)didChangeObject:(ShoppingHistoryEntry *)item value:(NSString *)value
{
    [item setName:value];
}

#pragma mark -
#pragma mark HistoryEntryController (Private)

@synthesize searchController = _searchController,
    filteredController = _filteredController;

+ (void)initializePredicateTemplates
{
    NSExpression *lhs =
            [NSExpression expressionForKeyPath:kShoppingHistoryEntryName];
    NSExpression *rhs =
            [NSExpression expressionForVariable:kNameVariableKey];

    kEntriesPredicateTemplate = [[NSComparisonPredicate
        predicateWithLeftExpression:lhs
        rightExpression:rhs
        modifier:NSDirectPredicateModifier
        type:NSLikePredicateOperatorType
        options:NSCaseInsensitivePredicateOption |
            NSDiacriticInsensitivePredicateOption] retain];
}

#pragma mark -
#pragma mark HistoryEntryController (Public)

@synthesize delegate = _delegate;

+ (NSPredicate *)predicateForEntriesLikeName:(NSString *)name
{
    return [kEntriesPredicateTemplate predicateWithSubstitutionVariables:
            [NSDictionary dictionaryWithObject:
                    [NSNull nullOrObject:
                        [NSString stringWithFormat:@"*%@*", name]]
                forKey:kNameVariableKey]];
}

- (id)initWithDelegate:(id)delegate
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:
            kShoppingHistoryEntryName ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingHistoryEntryEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setAllowsMovableCells:NO];
        [self setDelegate:delegate];
        [self setTitle:NSLocalizedString(kHistoryEntryTitle, nil)];
        // Configure the results controller for searches
        _filteredController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:[[self resultsController] fetchRequest]
                managedObjectContext:context
                sectionNameKeyPath:nil
                cacheName:nil];
        [_filteredController setDelegate:self];
        [_searchController setDelegate:self];
    }
    return self;
}

#pragma mark -
#pragma mark HistoryEntryController (EventHandler)

- (void)addHistoryEntry:(UIControl *)control
{
    if ([_delegate respondsToSelector:
            @selector(historyEntryController:historyEntry:withText:)])
    {
        // we need to insert a new history entry so historyEntry should be nil
        NSString *searchText = 
                [[[self searchDisplayController] searchBar] text];
        if (searchText != nil && [[_filteredController
                fetchedObjects] count] == 0){
            [_delegate historyEntryController:self historyEntry:nil
                    withText:searchText];
        } else {
            [_delegate historyEntryController:self historyEntry:nil
                                     withText:nil];
        }
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark HistoryEntryController <UISearchDisplayDelegate>

- (BOOL)    searchDisplayController:(UISearchDisplayController *)controller
   shouldReloadTableForSearchString:(NSString *)searchString
{
    [[_filteredController fetchRequest] setPredicate:
            [HistoryEntryController predicateForEntriesLikeName:searchString]];
    
    NSError *error = nil;

    if (![_filteredController performFetch:&error])
        [error log];
    return YES;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows =
            [super tableView:tableView numberOfRowsInSection:section];
    
    if (numberOfRows == 0 && noLists) {
        UIAlertView *alertView = [[[UIAlertView alloc]
                initWithTitle:kHistoryEntryAlertTitle
                    message:kHistoryEntryAlertMessage delegate:nil
                    cancelButtonTitle:kHistoryEntryAlertCancel
                    otherButtonTitles:kHistoryEntryAlertCreate, nil]
                    autorelease];
        
        [alertView show];
        noLists = NO;
    }
    return numberOfRows;
}
@end
