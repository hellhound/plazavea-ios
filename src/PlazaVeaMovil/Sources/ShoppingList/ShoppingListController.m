#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSError+Additions.h"
#import "Common/Views/InputView.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (Private)

- (void)initializeResultsController;
// Event handlers
- (void)addShoppingList:(UIControl *)control;
- (void)changeShoppingListName:(UIControl *) control;
- (void)cancelEditing:(UIControl *)control;
- (void)performUndo:(UIControl *)control;
- (void)performRedo:(UIControl *)control;
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
        // UIApplication delegate; weak assigment due to the delegate being a
        // singleton
        _appDelegate = [[UIApplication sharedApplication] delegate];
        [self initializeResultsController];
        // Allow selection of rows during editing
        [[self tableView] setAllowsSelectionDuringEditing:YES];
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

        NSManagedObjectContext *context = [_appDelegate context];

        if ([context hasChanges]) {
            [_appDelegate saveContext];
            [[context undoManager] removeAllActions];
            [[self tableView] reloadData];
        }
    }
}

#pragma mark -
#pragma mark ShoppingListController

- (void)initializeResultsController
{
    NSManagedObjectContext *context = [_appDelegate context];
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
    [self performFetch];
}

- (void)addShoppingList:(UIControl *)control
{
    InputView *inputView =
            [[[InputView alloc] initWithTitle:
                    NSLocalizedString(kShoppingListNewTitle, nil)
                message:NSLocalizedString(kShoppingListNewMessage, nil)
                delegate:self cancelButtonTitle:
                    NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
                otherButtonTitles:
                    NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                     nil] autorelease];

    [inputView setTag:kShoppingListCreationTag];
    [inputView show];
}

- (void)changeShoppingListName:(UIControl *)control
{
    InputView *inputView =
            [[[InputView alloc] initWithTitle:
                    NSLocalizedString(kShoppingListNewTitle, nil)
                message:NSLocalizedString(kShoppingListNewMessage, nil)
                delegate:self cancelButtonTitle:
                    NSLocalizedString(kShoppingListNewCancelButtonTitle, nil)
                otherButtonTitles:
                    NSLocalizedString(kShoppingListNewOkButtonTitle, nil),
                     nil] autorelease];

    [inputView setTag:kShoppingListCreationTag];
    [inputView show];
}

- (void)cancelEditing:(UIControl *)control
{
    NSManagedObjectContext *context = [_appDelegate context];

    [context rollback];
    [[self tableView] reloadData];
    [self setEditing:NO animated:YES];
}

- (void)performUndo:(UIControl *)control
{
    NSManagedObjectContext *context = [_appDelegate context];

    if ([_undoItem isEnabled]) {
        [context undo];
        [self updateUndoRedo];
        [[self tableView] reloadData];
    }
}

- (void)performRedo:(UIControl *)control
{
    NSManagedObjectContext *context = [_appDelegate context];

    if ([_redoItem isEnabled]) {
        [context redo];
        [self updateUndoRedo];
        [[self tableView] reloadData];
    }
}

#pragma mark -
#pragma mark ShoppingListController (Public)

- (void)performFetch
{
    NSError *error = nil;

    if (![_resultsController performFetch:&error])
        [error log];
}

- (void)updateUndoRedo
{
    NSUndoManager *undoManager = [[_appDelegate context] undoManager];

    [_undoItem setEnabled:[undoManager canUndo]];
    [_redoItem setEnabled:[undoManager canRedo]];
}
@end
