#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Composition/Constants.h"
#import "Composition/Models.h"
#import "Composition/FoodDetailController.h"
#import "Composition/FoodListController.h"

static NSPredicate *kFoodsPredicateTemplate;
static NSString *const kFoodVariableKey = @"FOOD";
static NSString *kPredicateNameVariableKey = @"NAME";

@interface FoodListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, readonly) NSFetchedResultsController *filteredController;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@end

@interface FoodListController (Private)

+ (void)initializePredicateTemplates;
@end

@implementation FoodListController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [FoodListController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    [_filteredController setDelegate:nil];
    [_filteredController release];
    [_searchController setDelegate:nil];
    [_searchController release];
    [_foodCategory release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    if (_navItem == nil){
        _navItem = [super navigationItem];
        [_navItem setRightBarButtonItem:nil];
    }
    return _navItem;
}

#pragma mark -
#pragma mark UIView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [self tableView];
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                         autorelease]];
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
                         autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];    
    // Conf search
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    
    [searchBar sizeToFit];
    [searchBar setTag:100];
    [searchBar setDelegate:self];
    [self setSearchController:[[[UISearchDisplayController alloc]
            initWithSearchBar:searchBar contentsController:self] autorelease]];
    [_searchController setDelegate:self];
    [_searchController setSearchResultsDataSource:self];
    [_searchController setSearchResultsDelegate:self];
    [_headerView addSubview:searchBar];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark FoodListController (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs = [NSExpression expressionForKeyPath:kFoodCategory];
    NSExpression *rhs = [NSExpression expressionForVariable:kFoodVariableKey];
    
    kFoodsPredicateTemplate = [[NSComparisonPredicate 
            predicateWithLeftExpression:lhs rightExpression:rhs
                modifier:NSDirectPredicateModifier type:
                NSEqualToPredicateOperatorType options:0] retain];
}

#pragma mark -
#pragma mark FoodListController (Public)

@synthesize foodCategory = _foodCategory, headerView = _headerView,
        titleLabel = _titleLabel, searchController = _searchController,
            filteredController = _filteredController;

- (id)initWithCategory:(FoodCategory *)foodCategory;
{
    if ((self = [super initWithStyle:UITableViewStylePlain]) != nil) {
        NSArray *sortDescriptors = [NSArray arrayWithObject:
                [[[NSSortDescriptor alloc] initWithKey:kFoodName ascending:YES]
                    autorelease]];
        NSManagedObjectContext *context = [(AppDelegate *)
                [[UIApplication sharedApplication] delegate] context];
        NSPredicate *predicate = [kFoodsPredicateTemplate 
                predicateWithSubstitutionVariables: [NSDictionary
                    dictionaryWithObject:[NSNull nullOrObject:foodCategory]
                    forKey:kFoodVariableKey]];
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
        
        [request setEntity:[NSEntityDescription entityForName:kFoodEntity
                inManagedObjectContext:context]];
        [request setPredicate:predicate];
        [request setSortDescriptors:sortDescriptors];
        // Conf fetch-request controller
        _resultsController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:request
                managedObjectContext:context
                sectionNameKeyPath:kFoodInitial 
                cacheName:nil];
        
        [_resultsController setDelegate:self];
        [self performFetch];
        [self setAllowsRowDeselection:YES];
        [self setPerformsSelectionAction:YES];
        [self setFoodCategory:foodCategory];
        // Conf table header
        UITableView *tableView = [self tableView];

        NSString *title = [_foodCategory name];
        UIFont *font = [_titleLabel font];
        CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
        CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
        CGFloat titleHeight = [title sizeWithFont:font
                constrainedToSize:constrainedTitleSize
                    lineBreakMode:UILineBreakModeWordWrap].height;
        CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
        
        [_titleLabel setText:title];
        [_titleLabel setFrame:titleFrame];
        // Adding the subviews to the header view
        [_headerView addSubview:_titleLabel];
        
        UISearchBar *searchBar = (UISearchBar *)[_headerView viewWithTag:100];
        
        CGRect searchFrame = [searchBar frame];
        searchFrame.origin.y += titleHeight;
        [searchBar setFrame:searchFrame];
        CGFloat searchHeight = CGRectGetHeight(searchFrame);
        CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
        CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
                titleHeight + searchHeight);
        
        [_headerView setFrame:headerFrame];
        [tableView setTableHeaderView:_headerView];
        // Configure the results controller for searches
        NSArray *filteredSortDescriptors = [NSArray arrayWithObject:
                [[[NSSortDescriptor alloc] initWithKey:kFoodName
                    ascending:YES] autorelease]];
        NSFetchRequest *searchRequest =
                [[[NSFetchRequest alloc] init] autorelease];
        
        [searchRequest setEntity:[NSEntityDescription 
                entityForName:kFoodEntity
                    inManagedObjectContext:context]];
        [searchRequest setSortDescriptors:filteredSortDescriptors];
        _filteredController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:searchRequest
                    managedObjectContext:context
                    sectionNameKeyPath:nil
                    cacheName:nil];
        [_filteredController setDelegate:self];
        [_searchController setDelegate:self];
    }
    return self;
}

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    Food *food = (Food *)object;
    
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:[food name]];
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (BOOL)    tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == [self tableView])
        return [_resultsController sectionIndexTitles];
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == [self tableView])
        return [[_resultsController sections] count];
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (tableView == [self tableView])
        return [[_resultsController sectionIndexTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (tableView == [self tableView]) {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_filteredController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == [self tableView]){
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else {
        NSManagedObject *object =
        [_filteredController objectAtIndexPath:indexPath];
        Class cellClass =
        [self cellClassForObject:object atIndexPath:indexPath];
        NSString *reuseIdentifier = NSStringFromClass(cellClass);
        
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell = [self cellForObject:object withCellClass:cellClass
                         reuseCell:cell reuseIdentifier:reuseIdentifier
                       atIndexPath:indexPath];
        [self didCreateCell:cell forObject:object atIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(EditableTableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil)
        cell = [[[EditableTableViewCell alloc]
                 initWithStyle:_cellStyle
                    reuseIdentifier:reuseIdentifier] autorelease];
    return cell;
}

- (void)didSelectRowForObject:(Food *)food
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing]) {
        [[self navigationController] pushViewController:
                [[[FoodDetailController alloc] initWithFood:food] autorelease]
                    animated:YES];
    }
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        Food *food = [_filteredController objectAtIndexPath:indexPath];
        [[self navigationController] pushViewController:
                [[[FoodDetailController alloc] initWithFood:food] autorelease]
                    animated:YES];
    }
}

#pragma mark -
#pragma mark HistoryEntryController <UISearchDisplayDelegate>

- (BOOL)    searchDisplayController:(UISearchDisplayController *)controller
   shouldReloadTableForSearchString:(NSString *)searchString
{
    NSExpression *lhsName = [NSExpression expressionForKeyPath:kFoodName];
    NSExpression *rhsName =
            [NSExpression expressionForVariable:kPredicateNameVariableKey];
    
    NSPredicate *kNamePredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhsName
                rightExpression:rhsName
                modifier:NSDirectPredicateModifier
                type:NSLikePredicateOperatorType
                options:NSCaseInsensitivePredicateOption |
                NSDiacriticInsensitivePredicateOption] retain];
    NSPredicate * predicateName = 
            [kNamePredicateTemplate predicateWithSubstitutionVariables:
                [NSDictionary dictionaryWithObject:
                [NSNull nullOrObject:
                [NSString stringWithFormat:@"*%@*", searchString]]
                forKey:kPredicateNameVariableKey]];
    NSPredicate *predicateCat = [kFoodsPredicateTemplate 
            predicateWithSubstitutionVariables: [NSDictionary
                dictionaryWithObject:[NSNull nullOrObject:_foodCategory]
                forKey:kFoodVariableKey]];
    
    [[_filteredController fetchRequest] setPredicate:[NSCompoundPredicate
            andPredicateWithSubpredicates:[NSArray arrayWithObjects:
                predicateName, predicateCat, nil]]];
    
    NSError *error = nil;
    
    if (![_filteredController performFetch:&error])
        [error log];
    return YES;
}   
@end