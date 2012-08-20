#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyCategoryController.h"
#import "Emergency/EmergencyNumberController.h"

static CGFloat margin = 5.;
static CGFloat sectionHeight = 24.;
static CGFloat headerMinHeight = 40.;
static CGFloat disclousureWidth = 20.;
static CGFloat indexWitdh = 50.;
static CGFloat phoneHeight = 10.;

@interface EmergencyCategoryController ()

// @private
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, readonly) NSFetchedResultsController *filteredController;
@property (nonatomic, retain) UISearchDisplayController *searchController;

@end

@implementation EmergencyCategoryController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyCategoryName
                ascending:YES] autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kEmergencyCategoryEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kEmergencyCategoryTitle, nil)];
        [self setCellStyle:UITableViewCellStyleSubtitle];

        // Configure the results controller for searches
        NSString *categoryKey = 
                [NSString stringWithFormat:@"%@.%@",kEmergencyNumberCategory,
                    kEmergencyCategoryName];
        NSArray *filteredSortDescriptors = [NSArray arrayWithObject:
                [[[NSSortDescriptor alloc] initWithKey:categoryKey
                    ascending:YES] autorelease]];
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

        [request setEntity:[NSEntityDescription 
                entityForName:kEmergencyNumberEntity
                inManagedObjectContext:_context]];
        [request setSortDescriptors:filteredSortDescriptors];
        _filteredController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:request
                managedObjectContext:context
                sectionNameKeyPath:categoryKey
                cacheName:nil];
        [_filteredController setDelegate:self];
        [_searchController setDelegate:self];
        [EmergencyFile loadFromCSVinContext:context];
    }
    return self;
}

- (void) dealloc
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
            initWithImage:TTIMAGE(kEmergencyCategoryBanner)] autorelease];
    
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
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerShadowColor)]) {
        [_titleLabel setShadowColor:(UIColor *)TTSTYLE(headerShadowColor)];
        [_titleLabel setShadowOffset:CGSizeMake(.0, -1.)];
    }
    
    NSString *title = kEmergencyCategoryTitle;
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
    // Setup searchBar and searchDisplayController
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];

    [searchBar sizeToFit];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(emergencySearchBarColor)]) {
        [searchBar setTintColor:(UIColor *)TTSTYLE(emergencySearchBarColor)];
    }
    [searchBar setDelegate:self];
    [self setSearchController:
            [[[UISearchDisplayController alloc] initWithSearchBar:searchBar
                contentsController:self] autorelease]];
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
            @selector(emergencyBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(emergencyBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:imageView];
    [_headerView addSubview:searchBar];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

- (void)viewDidUnload
{
    [self setSearchController:nil];
}

#pragma mark -
#pragma mark EmergencyCategoryController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel, 
        searchController = _searchController,
            filteredController = _filteredController;

#pragma mark -
#pragma mark EmergencyCategoryController

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    if ([object isKindOfClass:[EmergencyCategory class]]) {
        EmergencyCategory *category = (EmergencyCategory *)object;
        
        [[cell textLabel] setText:[category name]];
        [[cell detailTextLabel] setText:nil];
        [[cell textLabel] setNumberOfLines:0];
        [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:18.]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } else {
        EmergencyNumber *emergencyNumber = (EmergencyNumber *)object;
        
        [[cell textLabel] setText:[emergencyNumber name]];
        [[cell detailTextLabel] setText:[emergencyNumber phone]];
        [[cell textLabel] setNumberOfLines:0];
        [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:18.]];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:
        (NSManagedObject *)object
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

- (void)didSelectRowForObject:(NSManagedObject *)emergencyObject
                  atIndexPath:(NSIndexPath *)indexPath
{
    if ([emergencyObject isKindOfClass:[EmergencyCategory class]]) {
        if (![self isEditing])
            [[self navigationController]
                    pushViewController:
                        [[[EmergencyNumberController alloc]
                            initWithCategory:(EmergencyCategory *)
                                emergencyObject] autorelease]
                    animated:YES];
    } else {
        NSCharacterSet *characterSet = 
            [NSCharacterSet characterSetWithCharactersInString:@" -"];
        NSString *phoneNumber = [[[(EmergencyNumber *)emergencyObject phone]
                componentsSeparatedByCharactersInSet:characterSet]
                componentsJoinedByString: @""];
        NSString *formatedNumber =
                [NSString stringWithFormat:@"tel://%@", phoneNumber];
        [[UIApplication sharedApplication]
                openURL:[NSURL URLWithString:formatedNumber]];
    }
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (tableView == [self tableView])
        return [super tableView:tableView numberOfRowsInSection:section];

    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_filteredController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == [self tableView])
        return [[_resultsController sections] count];
    return [[_filteredController sections] count];
}

/*- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ((tableView == [self tableView]) &&
            ([[_resultsController sections] count] > 4)) {
        return [_resultsController sectionIndexTitles];
    }
    if ((tableView != [self tableView]) &&
            ([[_filteredController sections] count] > 4)) {
        return [_filteredController sectionIndexTitles];
    }
    return nil;
}*/

- (NSInteger)      tableView:(UITableView *)tableView 
 sectionForSectionIndexTitle:(NSString *)title
                     atIndex:(NSInteger)index
{
    if (tableView == [self tableView])
        return [_resultsController sectionForSectionIndexTitle:title
                atIndex:index];
    return [_filteredController sectionForSectionIndexTitle:title
            atIndex:index];
}

- (NSString *)  tableView:(UITableView *)tableView
  titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo;
    if (tableView == [self tableView]) {
        sectionInfo = 
                [[_resultsController sections] objectAtIndex:section];
    } else {
        sectionInfo = 
                [[_filteredController sections] objectAtIndex:section];
    }
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
#pragma mark HistoryEntryController <UISearchDisplayDelegate>

- (BOOL)    searchDisplayController:(UISearchDisplayController *)controller
   shouldReloadTableForSearchString:(NSString *)searchString
{
    [[_filteredController fetchRequest] setPredicate:
            [EmergencyNumber predicateForEntriesLike:searchString]];
    
    NSError *error = nil;

    if (![_filteredController performFetch:&error])
        [error log];
    return YES;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *label;
    CGFloat accessoryWidth = disclousureWidth;
    CGFloat extraHeight = .0;
    
    if (tableView == [self tableView]) {
        label = [(EmergencyNumber *)[_resultsController
                objectAtIndexPath:indexPath] name];
        accessoryWidth = ([[_resultsController sections] count] > 4) ?
                indexWitdh : disclousureWidth;
    } else {
        label = [(EmergencyNumber *)[_filteredController
                objectAtIndexPath:indexPath] name];
        accessoryWidth = indexWitdh - accessoryWidth;
        extraHeight = phoneHeight;
    }
    CGSize constrainedSize = [tableView frame].size;
    constrainedSize.width -= (margin * 4) + accessoryWidth;
    CGFloat cellHeight = [label sizeWithFont:[UIFont boldSystemFontOfSize:18.]
            constrainedToSize:constrainedSize lineBreakMode:
                UILineBreakModeWordWrap].height + (margin * 4) + extraHeight;
    
    return cellHeight;
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        if ((_allowsRowDeselection && ![self isEditing]) ||
                (_allowsRowDeselectionOnEditing && [self isEditing])) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        if (_performsSelectionAction)
            [self didSelectRowForObject:
                    [_filteredController objectAtIndexPath:indexPath]
                        atIndexPath:indexPath];
    }
}

- (void)                        tableView:(UITableView *)tableView
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView
                accessoryButtonTappedForRowWithIndexPath:indexPath];
    } else {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
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
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerShadowColor)]) {
        [title setShadowColor:(UIColor *)TTSTYLE(headerShadowColor)];
        [title setShadowOffset:CGSizeMake(.0, -1.)];
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
            TTSTYLE(emergencySectionHeaderBackground)] autorelease];
    UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    CGRect viewFrame = CGRectMake(0, 0, titleWidth, sectionHeight);
    [view setFrame:viewFrame];
    [view addSubview:back];
    [view addSubview:title];
    return view;
}
@end
