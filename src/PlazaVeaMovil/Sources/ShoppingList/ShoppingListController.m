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

@interface ShoppingListController (Private)

- (void)addShoppingList:(UIControl *)control;
- (void)cancelEditing:(UIControl *)control;
- (void)performUndo:(UIControl *)control;
- (void)performRedo:(UIControl *)control;
- (void)updateUndoRedo;
@end

@implementation ShoppingListController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_fetchRequest release];
    [_resultsController release];
    [_undoItem release];
    [_redoItem release];
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
                initWithKey:kShoppingListOrder ascending:NO] autorelease];

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
                //cacheName:kShoppingListCacheName];
                cacheName:nil];
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

    if (_undoItem == nil)
        // Conf the undo item
        _undoItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                target:self action:@selector(performUndo:)];
    if (_redoItem == nil)
        // Conf the redo item
        _redoItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemRedo
                target:self action:@selector(performRedo:)];
    UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:NULL] autorelease];
    // Conf the add-item button
    UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
            target:self action:@selector(addShoppingList:)] autorelease];

    // Conf the toolbar
    [self setToolbarItems:[NSArray arrayWithObjects:_undoItem, _redoItem,
            spacerItem, addItem, nil]];
    [self updateUndoRedo];
    return navItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    UINavigationController *navController = [self navigationController];

    if (navController == nil)
        // Abort, we don't need fancy toggling
        return;

    UINavigationItem *navItem = [super navigationItem];

    if (editing) {
        // Conf the cancel-item button
        [navItem setLeftBarButtonItem:
                [[[UIBarButtonItem alloc]
                    initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                    target:self action:@selector(cancelEditing:)] autorelease]];
        // Hide the toolbar
        [navController setToolbarHidden:NO animated:animated];
    } else {
        [navItem setLeftBarButtonItem:nil];
        // Show the toolbar
        [navController setToolbarHidden:YES animated:animated];

        NSManagedObjectContext *context =
                [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                    context];

        if ([context hasChanges]) {
            NSError *error = nil;

            if ([context save:&error])
                [error log];
            [[context undoManager] removeAllActions];
            [[self tableView] reloadData];
        }
    }
}

#pragma mark -
#pragma mark ShoppingListController

- (void)addShoppingList:(UIControl *)control
{
    // Create and retain an input view
    InputView *inputView =
            [[[InputView alloc] initWithTitle:
                    NSLocalizedString(kShoppingListNewTitle, nil)
                message:NSLocalizedString(kShoppingListNewMessage, nil)
                delegate:self cancelButtonTitle:
                    NSLocalizedString(kShoppingListNewOkButtonTitle, nil)
                otherButtonTitles:
                    NSLocalizedString(kShoppingListNewCancelButtonTitle, nil),
                     nil] autorelease];

    [inputView show];
}

- (void)cancelEditing:(UIControl *)control
{
    NSManagedObjectContext *context =
            [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                context];

    [context rollback];
    [[self tableView] reloadData];
    [self setEditing:NO animated:YES];
}

- (void)performUndo:(UIControl *)control
{
    NSManagedObjectContext *context =
            [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                context];

    if ([_undoItem isEnabled]) {
        [context undo];
        [self updateUndoRedo];
        [[self tableView] reloadData];
    }
}

- (void)performRedo:(UIControl *)control
{
    NSManagedObjectContext *context =
            [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                context];

    if ([_redoItem isEnabled]) {
        [context redo];
        [self updateUndoRedo];
        [[self tableView] reloadData];
    }
}

- (void)updateUndoRedo
{
    NSUndoManager *undoManager =
            [[(AppDelegate *)[[UIApplication sharedApplication] delegate]
                context] undoManager];

    [_undoItem setEnabled:[undoManager canUndo]];
    [_redoItem setEnabled:[undoManager canRedo]];
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
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark <NSFetchedResultsControllerDelegate>

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // NO-OP. This empty method is intentional. Implementing any delegate method
    // triggers the change-tracking functionality of the fetch-request
    // controller;
}

#pragma mark -
#pragma mark <UIAlertViewDelegate>

- (void)            alertView:(InputView *)inputView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSManagedObjectContext *context =
                [(AppDelegate *)[[UIApplication sharedApplication] delegate]
                    context];
        ShoppingList *newList =
                [NSEntityDescription insertNewObjectForEntityForName:
                    kShoppingListEntity
                inManagedObjectContext:context];
        NSInteger order = [(NSNumber *)[[_resultsController fetchedObjects]
                valueForKeyPath:@"@max.order"] integerValue] + 1;

        [newList setName:[[inputView textField] text]];
        [newList setOrder:[NSNumber numberWithInteger:order]];

        NSError *error = nil;

        if (![_resultsController performFetch:&error])
            [error log];
        [[self tableView] reloadData];
        [self updateUndoRedo];
    }
}
@end
