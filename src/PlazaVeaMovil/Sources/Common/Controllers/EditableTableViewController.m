#import <stdlib.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSError+Additions.h"
#import "Common/Controllers/EditableTableViewController.h"

@interface EditableTableViewController (Private)

- (void)initializeResultsControllerWithEntityName:(NSString *)entityName
                                       predicate:(NSPredicate *)predicate
                                 sortDescriptors:(NSArray *)sortDescriptors;
@end

@implementation EditableTableViewController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_resultsController release];
    [_context release];
    [_undoItem release];
    [_redoItem release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // Conf the edit button
    [navItem setRightBarButtonItem:[self editButtonItem]];
    if (_undoItem == nil)
        // Conf the undo item
        _undoItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                target:self action:@selector(performUndoHandler:)];
    if (_redoItem == nil)
        // Conf the redo item
        _redoItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemRedo
                target:self action:@selector(performRedoHandler:)];
    // Conf the toolbar
    [self setToolbarItems:[NSArray arrayWithObjects:_undoItem, _redoItem, nil]];
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
                    target:self
                    action:@selector(cancelEditingHandler:)] autorelease]];
        // Hide the toolbar
        [navController setToolbarHidden:NO animated:animated];
    } else {
        [navItem setLeftBarButtonItem:nil];
        // Show the toolbar
        [navController setToolbarHidden:YES animated:animated];
        if ([_context hasChanges]) {
            [self saveContext];
            [[_context undoManager] removeAllActions];
            [self reload];
        }
    }
}

#pragma mark -
#pragma mark EditableTableViewController (Private)


- (void)initializeResultsControllerWithEntityName:(NSString *)entityName
                                       predicate:(NSPredicate *)predicate
                                 sortDescriptors:(NSArray *)sortDescriptors
{
    // Conf the fetch request
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName
            inManagedObjectContext:_context]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    // Conf fetch-request controller
    _resultsController = [[NSFetchedResultsController alloc]
            initWithFetchRequest:fetchRequest
            managedObjectContext:_context
            sectionNameKeyPath:nil
            //cacheName:withCache??????];
            cacheName:nil];
    // Set this controller as the delegate of the fetch-request controller.
    // When this is set, the fetch-reqeust controller begin tracking changes
    // to managed objects associated with its managed context.
    [_resultsController setDelegate:self];
    [self performFetch];
}

#pragma mark -
#pragma mark EditableTableViewController (Public)

@synthesize resultsController = _resultsController, context = _context,
        undoItem = _undoItem, redoItem = _redoItem;

- (id)initWithStyle:(UITableViewStyle)style
         entityName:(NSString *)entityName
          predicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
          inContext:(NSManagedObjectContext *)context
{
    if ((self = [super initWithStyle:style]) != nil) {
        _context = [context retain];
        [self initializeResultsControllerWithEntityName:entityName
                predicate:predicate sortDescriptors:sortDescriptors];
        // Allow selection of rows during editing
        [[self tableView] setAllowsSelectionDuringEditing:YES];
    }
    return self;
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (Class)cellClassForObject:(NSManagedObject *)object
                atIndexPath:(NSIndexPath *)indexPath;
{
    return [UITableViewCell class];
}

- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(UITableViewCell *)reuseCell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath;
{
    if (reuseCell == nil)
    reuseCell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:reuseIdentifier] autorelease];
    return reuseCell;
}

- (void)didSelectRowForObject:(NSManagedObject *)object
                  atIndexPath:(NSIndexPath *)indexPath
{
    // NO-OP
}

#pragma mark -
#pragma mark EditableTableViewController (EnventHandler)

- (void)cancelEditingHandler:(UIControl *)control
{
    [self rollbackAndReload];
    [self setEditing:NO animated:YES];
}

- (void)performUndoHandler:(UIControl *)control
{
    if ([_undoItem isEnabled]) {
        [_context undo];
        [self updateAndReload];
    }
}

- (void)performRedoHandler:(UIControl *)control
{
    if ([_redoItem isEnabled]) {
        [_context redo];
        [self updateAndReload];
    }
}

#pragma mark -
#pragma mark EditableTableViewController (CoreData)

- (void)reload
{
    [[self tableView] reloadData];
}

- (void)performFetch
{
    NSError *error = nil;

    if (![_resultsController performFetch:&error])
        [error log];
}

- (void)updateUndoRedo
{
    NSUndoManager *undoManager = [_context undoManager];

    [_undoItem setEnabled:[undoManager canUndo]];
    [_redoItem setEnabled:[undoManager canRedo]];
}

- (void)saveContext
{
    NSError *error = nil;

    if (_context != nil && [_context hasChanges] && ![_context save:&error]) {
        // Something shitty just happened, abort, abort, abort!
        [error log];
        // TODO should present a nice UIViewAlert informing the error
        abort();
    }
}

- (void)updateAndReload
{
    [self updateUndoRedo];
    [self reload];
}

- (void)fetchAndUpdate
{
    [self performFetch];
    [self updateUndoRedo];
}

- (void)fetchUpdateAndReload
{
    [self performFetch];
    [self updateAndReload];
}

- (void)rollbackAndReload
{
    [_context rollback];
    [self reload];
}
@end
