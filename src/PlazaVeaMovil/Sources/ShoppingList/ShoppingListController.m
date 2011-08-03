#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSError+Additions.h"
#import "Common/Views/InputView.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListController.h"

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_fetchRequest release];
    [_resultsController release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        NSManagedObjectContext *context =
                [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                    context];
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc]
                initWithKey:kShoppingListOrder ascending:YES] autorelease];

        // Conf the fetch request
        _fetchRequest = [[NSFetchRequest alloc] init];
        [_fetchRequest setSortDescriptors:
                [NSArray arrayWithObjects:sortDescriptor, nil]];
        [_fetchRequest setEntity:
                [NSEntityDescription entityForName:kShoppingListEntity
                    inManagedObjectContext:context]];
        // Conf fetch-request controller
        _resultsController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:_fetchRequest
                managedObjectContext:context
                sectionNameKeyPath:nil
                cacheName:kShoppingListCacheName];
        // Set this controller as the delegate of the fetch-request controller.
        // When this is set, the fetch-reqeust controller begin tracking changes
        // to managed objects associated with its managed context.
        [_resultsController setDelegate:self];

        NSError *error = nil;

        if (![_resultsController performFetch:&error])
            [error log];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // TODO We should use titleView instead of title in the navigationItem
    // Conf the title
    [navItem setTitle:NSLocalizedString(kShoppingListTitle, nil)];
    // Conf the edit button
    [navItem setRightBarButtonItem:[self editButtonItem]];

    // Conf the add-item button
    UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
            target:nil action:nil] autorelease];
    UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:nil] autorelease];

    [self setToolbarItems:[NSArray arrayWithObjects:spacerItem, addItem, nil]];
    // show the toolbar
    [[self navigationController] setToolbarHidden:NO];
    return navItem;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo =
            [[_resultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO we need to optimize the reuseIdentifier, it should be defined
    // once
    NSString *reuseIdentifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    if (cell == nil)
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:reuseIdentifier] autorelease];

    ShoppingList *list = [_resultsController objectAtIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] dateFormatter];

    [[cell textLabel] setText:[list name]];
    [[cell detailTextLabel] setText:[dateFormatter stringFromDate:
            [list lastModificationDate]]];
    return cell;
}

#pragma mark -
#pragma mark <NSFetchedResultsControllerDelegate>

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // NO-OP. This empty method is intentional. Implementing any delegate method
    // triggers the change-tracking functionality of the fetch-request
    // controller;
}
@end
