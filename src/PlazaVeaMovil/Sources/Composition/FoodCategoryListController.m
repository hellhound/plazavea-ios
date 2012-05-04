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
static CGFloat sectionHeight = 24.;
static CGFloat headerMinHeight = 40.;
static CGFloat disclousureWidth = 20.;
static CGFloat indexWitdh = 50.;

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
        [FoodFile loadFromCSVinContext:context];
        [self setTitle:kFoodCategoryHeader];
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
    if (_navItem == nil) {
        _navItem = [super navigationItem];
        [_navItem setRightBarButtonItem:nil];
    }
    return _navItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [self tableView];
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
            autorelease]];
    // Conf the banner
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kFoodCategoryBanner)] autorelease];
    
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the label
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    NSString *title = kFoodCategoryHeader;
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
        titleHeight = headerMinHeight - (margin * 2);
    } else {
        titleFrame.origin.y += margin;
    }
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    
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
    
    CGRect imageFrame = [imageView frame];
    imageFrame.origin.y += titleHeight + (margin * 2.);
    
    [imageView setFrame:imageFrame];
    
    CGRect searchFrame = [searchBar frame];
    searchFrame.origin.y += titleHeight + imageFrame.size.height + (2 * margin);
    [searchBar setFrame:searchFrame];
    CGFloat searchHeight = CGRectGetHeight(searchFrame);
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            titleHeight + imageFrame.size.height + searchHeight + (2 * margin));
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
         @selector(compositionBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(compositionBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:imageView];
    [_headerView addSubview:searchBar];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
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
    if ([object isKindOfClass:[FoodCategory class]]) {
        FoodCategory *category = (FoodCategory *)object;
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [[cell textLabel] setNumberOfLines:0];
        [[cell textLabel] setText:[category name]];
        [[cell textLabel] setFont: [UIFont boldSystemFontOfSize:18.]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else {
        Food *food = (Food *)object;
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [[cell textLabel] setNumberOfLines:0];
        [[cell textLabel] setText:[food name]];
        [[cell textLabel] setFont: [UIFont boldSystemFontOfSize:18.]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
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
    if ((tableView != [self tableView]) &&
            ([[_filteredController sections] count] > 4)) {
        return [_filteredController sectionIndexTitles];
    }
    return nil;
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
    if (tableView == [self tableView]) {
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
    }
    return cell;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *label;
    CGFloat accessoryWidth = disclousureWidth;

    if (tableView == [self tableView]) {
        label = [(FoodCategory *)[_resultsController
                objectAtIndexPath:indexPath] name];
    } else {
        label = [(Food *)[_filteredController objectAtIndexPath:indexPath]
                name];
        accessoryWidth = ([[_filteredController sections] count] > 4) ?
                indexWitdh : disclousureWidth;
    }
    CGSize constrainedSize = [tableView frame].size;
    constrainedSize.width -= (margin * 4) + accessoryWidth;
    CGFloat cellHeight = [label sizeWithFont:[UIFont boldSystemFontOfSize:18.]
            constrainedToSize:constrainedSize
                lineBreakMode:UILineBreakModeWordWrap].height + (margin * 4);
    
    return cellHeight;
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

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section
{
    if (tableView == [self tableView])
        return 0;
    return sectionHeight;
}

- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section
{
    if (tableView == [self tableView])
        return nil;
    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_filteredController sections] objectAtIndex:section];
    NSString *sectionTitle = [sectionInfo name];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [title setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
         hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [title setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [title setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    UIFont *font = [title font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [sectionTitle sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake((margin * 2),
            .0 + ((sectionHeight - titleHeight) / 2), titleWidth, titleHeight);
    
    [title setText:sectionTitle];
    [title setFrame:titleFrame];
    
    UIImageView *back = [[[UIImageView alloc] initWithImage:(UIImage *)
            TTSTYLE(compositionSectionHeaderBackground)] autorelease];
    UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    CGRect viewFrame = CGRectMake(0, 0, titleWidth, sectionHeight);
    [view setFrame:viewFrame];
    [view addSubview:back];
    [view addSubview:title];
    return view;
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
