#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyCategoryController.h"
#import "Emergency/EmergencyNumberController.h"

@interface EmergencyCategoryController ()

// @private
@property (nonatomic, readonly)
    NSFetchedResultsController *filteredController;
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
        NSArray *filteredSortDescriptors = [NSArray arrayWithObject:
                [[[NSSortDescriptor alloc] initWithKey:kEmergencyNumberName
                    ascending:YES] autorelease]];
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

        [request setEntity:[NSEntityDescription 
                entityForName:kEmergencyNumberEntity
                inManagedObjectContext:_context]];
        [request setSortDescriptors:filteredSortDescriptors];
        _filteredController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:request
                managedObjectContext:context
                sectionNameKeyPath:nil
                cacheName:nil];
        [_filteredController setDelegate:self];
        [_searchController setDelegate:self];
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
    if (_navItem == nil){
        _navItem = [super navigationItem];
        [_navItem setRightBarButtonItem:nil];
    }
    return _navItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Setup searchBar and searchDisplayController
    UISearchBar *searchBar =
            [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];

    [searchBar sizeToFit];
    [searchBar setDelegate:self];
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
    [self setSearchController:nil];
}

#pragma mark -
#pragma mark EmergencyCategoryController (Private)

@synthesize searchController = _searchController,
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
    } else {
        EmergencyNumber *emergencyNumber = (EmergencyNumber *)object;
        [[cell textLabel] setText:[emergencyNumber name]];
        [[cell detailTextLabel] setText:[emergencyNumber phone]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == [self tableView]){
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        if ((_allowsRowDeselection && ![self isEditing]) ||
                (_allowsRowDeselectionOnEditing && [self isEditing])){
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
@end
