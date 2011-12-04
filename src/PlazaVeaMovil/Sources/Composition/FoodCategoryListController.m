#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Composition/Constants.h"
#import "Composition/Models.h"
#import "Composition/FoodListController.h"
#import "Composition/FoodDetailController.h"
#import "Composition/FoodCategoryListController.h"

static NSString *kPredicateNameVariableKey = @"NAME";
static CGFloat margin = 5.;

@interface FoodCategoryListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, readonly) NSFetchedResultsController *filteredController;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@end

@implementation FoodCategoryListController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kFoodCategoryName
                ascending:YES] autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    
    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kFoodCategoryEntity predicate:nil
                sortDescriptors:sortDescriptors inContext:context]) != nil) {
        // Configure the results controller for searches
        NSString *categoryKey = 
                [NSString stringWithFormat:@"%@.%@",kFoodCategory,kFoodName];
        NSArray *filteredSortDescriptors = [NSArray arrayWithObject:
                [[[NSSortDescriptor alloc] initWithKey:categoryKey
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
                    sectionNameKeyPath:categoryKey
                    cacheName:nil];
        [_filteredController setDelegate:self];
        [_searchController setDelegate:self];
    }
    return self;
}

- (void)dealloc
{
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
    if (_navItem == nil){
        _navItem = [super navigationItem];
        [_navItem setRightBarButtonItem:nil];
    }
    return _navItem;
}

#pragma mark -
#pragma mark UIView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UITableView *tableView = [self tableView];
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
            autorelease]];
    // Configuring the label
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(headerFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerFontColor)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerFontColor)];
    }
    
    NSString *title = kFoodCategoryHeader;
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0 + margin, titleWidth, titleHeight);
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    // Conf the background
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(compositionHeaderBackgroundImage)]) {
        [_headerView addSubview:
                (UIImageView *)TTSTYLE(compositionHeaderBackgroundImage)];
    }
    // Adding the subviews to the header view
    [_headerView addSubview:_titleLabel];
    // Conf search
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(compositionSearchBarColor)]) {
        [searchBar setTintColor:(UIColor *)TTSTYLE(compositionSearchBarColor)];
    }
    [searchBar sizeToFit];
    [searchBar setTag:100];
    [searchBar setDelegate:self];
    [self setSearchController:[[[UISearchDisplayController alloc]
            initWithSearchBar:searchBar contentsController:self] autorelease]];
    [_searchController setDelegate:self];
    [_searchController setSearchResultsDataSource:self];
    [_searchController setSearchResultsDelegate:self];
    [_headerView addSubview:searchBar];
    
    CGRect searchFrame = [searchBar frame];
    searchFrame.origin.y += titleHeight + (2 * margin);
    [searchBar setFrame:searchFrame];
    CGFloat searchHeight = CGRectGetHeight(searchFrame);
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0 + (2 * margin), boundsWidth,
            titleHeight + searchHeight);
    
    [_headerView setFrame:headerFrame];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark FoodCategoryListController

@synthesize headerView = _headerView, titleLabel = _titleLabel,
        filteredController = _filteredController,
            searchController = _searchController;

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    FoodCategory *category = (FoodCategory *)object;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:[category name]];
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

- (void)didSelectRowForObject:(FoodCategory *)foodCategory
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing]) {
        [[self navigationController] pushViewController:
                [[[FoodListController alloc] initWithCategory:foodCategory]
                    autorelease] animated:YES];
    }
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (BOOL)    tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == [self tableView])
        return [_resultsController sectionIndexTitles];
    return [_filteredController sectionIndexTitles];
}

-       (NSInteger)tableView:(UITableView *)tableView 
 sectionForSectionIndexTitle:(NSString *)title
                     atIndex:(NSInteger)index
{
    if (tableView == [self tableView])
        return [_resultsController sectionForSectionIndexTitle:title
                atIndex:index];
    return [_filteredController sectionForSectionIndexTitle:title
                atIndex:index];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == [self tableView])
        return [[_resultsController sections] count];
    return [[_filteredController sections] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (tableView == [self tableView])
        return nil;
    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_filteredController sections] objectAtIndex:section];
    
    return [sectionInfo name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == [self tableView]){
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
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
#pragma mark <UITableViewDelegate>

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
    NSExpression *lhsProperties =
            [NSExpression expressionForKeyPath:kFoodProperties];
    NSExpression *rhsProperties =
            [NSExpression expressionForVariable:kPredicateNameVariableKey];
    NSPredicate *kPropertiesPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhsProperties
                rightExpression:rhsProperties
                modifier:NSDirectPredicateModifier
                type:NSLikePredicateOperatorType
                options:NSCaseInsensitivePredicateOption |
                NSDiacriticInsensitivePredicateOption] retain];
    NSPredicate * predicateProperties = 
    [kPropertiesPredicateTemplate predicateWithSubstitutionVariables:
            [NSDictionary dictionaryWithObject:
                [NSNull nullOrObject:
                [NSString stringWithFormat:@"*%@*", searchString]]
                forKey:kPredicateNameVariableKey]];
    
    [[_filteredController fetchRequest] setPredicate:
            [NSCompoundPredicate orPredicateWithSubpredicates:
                [NSArray arrayWithObjects:predicateName, predicateProperties,
                 nil]]];
    
    NSError *error = nil;
    
    if (![_filteredController performFetch:&error])
        [error log];
    return YES;
}
@end
