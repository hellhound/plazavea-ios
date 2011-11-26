#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyNumberController.h"

static NSPredicate *kEmergencyNumbersPredicateTemplate;
static NSString *const kEmergencyNumberVariableKey = @"EMERGENCY_NUMBER";

@interface EmergencyNumberController ()

@property (nonatomic, readonly)
    NSFetchedResultsController *filteredController;
@property (nonatomic, retain) UISearchDisplayController *searchController;

+ (void)initializePredicateTemplates;
@end

@implementation EmergencyNumberController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [EmergencyNumberController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    [_filteredController setDelegate:nil];
    [_filteredController release];
    [_searchController setDelegate:nil];
    [_searchController release];
    [_emergencyCategory release];
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
#pragma mark EmergencyNumberController (Private)

@synthesize searchController = _searchController,
    filteredController = _filteredController;

+ (void)initializePredicateTemplates
{
    NSExpression *lhs =
            [NSExpression expressionForKeyPath:kEmergencyNumberCategory];
    NSExpression *rhs =
            [NSExpression expressionForVariable:kEmergencyNumberVariableKey];

    kEmergencyNumbersPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSEqualToPredicateOperatorType
            options:0] retain];
}

#pragma mark -
#pragma mark EmergencyNumberController (Public)

@synthesize emergencyCategory = _emergencyCategory;

- (id)initWithCategory:(EmergencyCategory *)emergencyCategory;
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyNumberName
                ascending:YES] autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];

    NSPredicate *predicate = [kEmergencyNumbersPredicateTemplate 
            predicateWithSubstitutionVariables:
                [NSDictionary dictionaryWithObject:
                    [NSNull nullOrObject:emergencyCategory]
                forKey:kEmergencyNumberVariableKey]];

    if ((self = [self initWithStyle:UITableViewStylePlain
            entityName:kEmergencyNumberEntity predicate:predicate
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kEmergencyNumberTitle, nil)];
        [self setEmergencyCategory:emergencyCategory];
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
    }
    return self;
}


- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    EmergencyNumber *emergencyNumber = (EmergencyNumber *)object;

    [[cell textLabel] setText:[emergencyNumber name]];
    [[cell detailTextLabel] setText:[emergencyNumber phone]];
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (id)initWithStyle:(UITableViewStyle)style
         entityName:(NSString *)entityName
          predicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
          inContext:(NSManagedObjectContext *)context
{
    if ((self = [super initWithStyle:style]) != nil) {
        _context = [context retain];
        if (entityName != nil) {
            // Conf the fetch request
            NSFetchRequest *request = 
                    [[[NSFetchRequest alloc] init] autorelease];

            [request setEntity:[NSEntityDescription entityForName:entityName
               inManagedObjectContext:_context]];
            [request setPredicate:predicate];
            [request setSortDescriptors:sortDescriptors];
            // Conf fetch-request controller
            _resultsController = [[NSFetchedResultsController alloc]
                    initWithFetchRequest:request
                    managedObjectContext:_context
                    sectionNameKeyPath:kEmergencyNumberFirstLetter
                    cacheName:nil];
            [_resultsController setDelegate:self];
            [self performFetch];
        }
        // Allow row deselection
        [self setAllowsRowDeselection:YES];
        [self setPerformsSelectionAction:YES];
    }
    return self;
}

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

- (void)didSelectRowForObject:(EmergencyNumber *)emergencyNumber
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing]){
        NSCharacterSet *characterSet = 
            [NSCharacterSet characterSetWithCharactersInString:@" -"];
        NSString *phoneNumber = [[[emergencyNumber phone]
                componentsSeparatedByCharactersInSet:characterSet]
                componentsJoinedByString: @""];
        NSString *formatedNumber =
                [NSString stringWithFormat:@"tel://%@", phoneNumber];
        [[UIApplication sharedApplication]
                openURL:[NSURL URLWithString:formatedNumber]];
    }
}

#pragma mark -
#pragma mark EmergencyNumberController<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (tableView == [self tableView]){
        id <NSFetchedResultsSectionInfo> sectionInfo = 
            [[_resultsController sections] objectAtIndex:section];
                return [sectionInfo numberOfObjects];
    }
    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_filteredController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == [self tableView])
        return [[_resultsController sections] count];
    return [[_filteredController sections] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == [self tableView])
        return [_resultsController sectionIndexTitles];
    return [_filteredController sectionIndexTitles];
}

-       (NSInteger)tableView:(UITableView *)tableView 
 sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == [self tableView])
        return [_resultsController sectionForSectionIndexTitle:title
                atIndex:index];
    return [_filteredController sectionForSectionIndexTitle:title
            atIndex:index];
}

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo;
    if (tableView == [self tableView]){
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
    if (tableView == [self tableView])
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];

    NSManagedObject *object =
            [_filteredController objectAtIndexPath:indexPath];
    Class cellClass = [self cellClassForObject:object atIndexPath:indexPath];
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    cell = [self cellForObject:object withCellClass:cellClass
            reuseCell:cell reuseIdentifier:reuseIdentifier
            atIndexPath:indexPath];
    [self didCreateCell:cell forObject:object atIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark EmergencyNumberController <UISearchDisplayDelegate>

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
