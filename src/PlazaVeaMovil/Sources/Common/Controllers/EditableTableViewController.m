#import <stdlib.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSError+Additions.h"
#import "Common/Controllers/EditableTableViewController.h"

static NSTimeInterval const kshowFlashScrollIndicatorsDelay = .15;

@interface EditableTableViewController (Private)

- (void)initializeResultsControllerWithEntityName:(NSString *)entityName
                                       predicate:(NSPredicate *)predicate
                                 sortDescriptors:(NSArray *)sortDescriptors;
- (BOOL)shouldHideReadonlyToolbar;
- (BOOL)shouldHideEditingToolbar;
- (BOOL)shouldShowReadonlyToolbar;
- (BOOL)shouldShowEditingToolbar;
- (BOOL)shouldAnimateToolbarToggling:(BOOL)animated;
@end

@implementation EditableTableViewController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    //[_resultsController release];
    _resultsController = nil;
    [_context release];
    [_cancelItem release];
    [_undoItem release];
    [_redoItem release];
    [_readonlyToolbarItems release];
    [_editingToolbarItems release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    // This here avoids recursion
    return [super initWithNibName:nibName bundle:bundle];
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // Conf the edit button
    [navItem setRightBarButtonItem:[self editButtonItem]];
    if (_cancelItem == nil)
        // Conf the cancel item
        _cancelItem = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
            target:self
            action:@selector(cancelEditingHandler:)];
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
    if (_editingToolbarItems == nil)
        // Conf the toolbar
        [[self editingToolbarItems] addObjectsFromArray:
                [NSArray arrayWithObjects:_undoItem, _redoItem, nil]];
    //Conf the color
    [self updateUndoRedo];
    return navItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //change the colors
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    UINavigationController *navController = [self navigationController];

    if (navController != nil) {
        UINavigationItem *navItem = [super navigationItem];

        if (editing) {
            // Conf the cancel-item button
            [navItem setLeftBarButtonItem:_cancelItem];
            // Hide the toolbar
            if ([self shouldHideReadonlyToolbar])
                [navController setToolbarHidden:YES
                        animated:[self shouldAnimateToolbarToggling:animated]];
            [self setToolbarItems:_editingToolbarItems];
            if ([self shouldShowEditingToolbar])
                [navController setToolbarHidden:NO
                        animated:[self shouldAnimateToolbarToggling:animated]];
        } else {
            [navItem setLeftBarButtonItem:nil];
            // Show the toolbar
            if ([self shouldHideEditingToolbar])
                [navController setToolbarHidden:YES
                        animated:[self shouldAnimateToolbarToggling:animated]];
            [self setToolbarItems:_readonlyToolbarItems];
            if ([self shouldShowReadonlyToolbar])
                [navController setToolbarHidden:NO
                        animated:[self shouldAnimateToolbarToggling:animated]];
        }
    }
    if (!editing && [_context hasChanges]) {
        [self saveContext];
        [self reload];
    }
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    // This here avoids recursion
    return [super initWithStyle:style];
}

#pragma mark -
#pragma mark EditableTableViewController (Private)


- (void)initializeResultsControllerWithEntityName:(NSString *)entityName
                                       predicate:(NSPredicate *)predicate
                                 sortDescriptors:(NSArray *)sortDescriptors
{
    if (entityName != nil) {
        // Conf the fetch request
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

        [request setEntity:[NSEntityDescription entityForName:entityName
           inManagedObjectContext:_context]];
        [request setPredicate:predicate];
        [request setSortDescriptors:sortDescriptors];
        // Conf fetch-request controller
        _resultsController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:request
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
}

- (BOOL)shouldHideReadonlyToolbar
{
    return _editingToolbarItems != nil || [_editingToolbarItems count] > 0;
}

- (BOOL)shouldHideEditingToolbar
{
    return _editingToolbarItems != nil || [_editingToolbarItems count] > 0;
}

- (BOOL)shouldShowReadonlyToolbar
{
    return _readonlyToolbarItems != nil || [_readonlyToolbarItems count] > 0;
}

- (BOOL)shouldShowEditingToolbar
{
    return _editingToolbarItems != nil || [_editingToolbarItems count] > 0;
}

- (BOOL)shouldAnimateToolbarToggling:(BOOL)animated
{
    return animated && !(_readonlyToolbarItems == _editingToolbarItems);
}

#pragma mark -
#pragma mark EditableTableViewController (Public)

@synthesize resultsController = _resultsController, context = _context,
        undoItem = _undoItem, redoItem = _redoItem,
        readonlyToolbarItems = _readonlyToolbarItems,
        editingToolbarItems = _editingToolbarItems,
        allowsRowDeselection = _allowsRowDeselection,
        allowsRowDeselectionOnEditing = _allowsRowDeselectionOnEditing,
        performsSelectionAction = _performsSelectionAction,
        allowsMovableCells = _allowsMovableCells;

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
        // Allow row deselection
        [self setAllowsRowDeselection:YES];
        [self setPerformsSelectionAction:YES];
    }
    return self;
}

- (void)scrollToTop
{
    UITableView *tableView = [self tableView];

    [tableView scrollToRowAtIndexPath:
                [NSIndexPath indexPathForRow:0 inSection:0]
            atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [tableView performSelector:@selector(flashScrollIndicators) withObject:nil
            afterDelay:kshowFlashScrollIndicatorsDelay];
}

- (NSMutableArray *)readonlyToolbarItems
{
    if (_readonlyToolbarItems == nil)
        _readonlyToolbarItems = [[NSMutableArray alloc] init];
    return _readonlyToolbarItems;
}

- (NSMutableArray *)editingToolbarItems
{
    if (_editingToolbarItems == nil)
        _editingToolbarItems = [[NSMutableArray alloc] init];
    return _editingToolbarItems;
}

- (void)setAllowsRowDeselection:(BOOL)allowsRowDeselection
{
    // Allow selection of rows
    _allowsRowDeselection = allowsRowDeselection;
    [[self tableView] setAllowsSelection:allowsRowDeselection];
}

- (void)setAllowsRowDeselectionOnEditing:(BOOL)allowsRowDeselection
{
    // Allow selection of rows during editing
    _allowsRowDeselectionOnEditing = allowsRowDeselection;
    [[self tableView] setAllowsSelectionDuringEditing:allowsRowDeselection];
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

- (void)didCreateCell:(UITableViewCell *)cell
            forObject:(NSManagedObject *)object
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
    [[_context undoManager] removeAllActions];
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
