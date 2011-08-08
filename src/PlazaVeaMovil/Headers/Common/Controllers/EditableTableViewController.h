#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EditableTableViewController: UITableViewController
    <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultsController;
    NSManagedObjectContext *_context;
    // Undo management items
    UIBarButtonItem *_undoItem;
    UIBarButtonItem *_redoItem;
    BOOL _allowsRowDeselection;
    BOOL _allowsRowDeselectionOnEditing;
    BOOL _performsSelectionAction;
}
@property (nonatomic, readonly) NSFetchedResultsController *resultsController;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) UIBarButtonItem *undoItem;
@property (nonatomic, retain) UIBarButtonItem *redoItem;
@property (nonatomic, assign) BOOL allowsRowDeselection;
@property (nonatomic, assign) BOOL allowsRowDeselectionOnEditing;
@property (nonatomic, assign) BOOL performsSelectionAction;

- (id)initWithStyle:(UITableViewStyle)style
         entityName:(NSString *)entityName
          predicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
          inContext:(NSManagedObjectContext *)context;
@end

@interface EditableTableViewController (Overridable)

- (Class)cellClassForObject:(NSManagedObject *)object
                atIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(UITableViewCell *)reuseCell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowForObject:(NSManagedObject *)object
                  atIndexPath:(NSIndexPath *)indexPath;
@end

@interface EditableTableViewController (EventHandler)

- (void)cancelEditingHandler:(UIControl *)control;
- (void)performUndoHandler:(UIControl *)control;
- (void)performRedoHandler:(UIControl *)control;
@end

@interface EditableTableViewController (CoreData)

- (void)reload;
- (void)performFetch;
- (void)updateUndoRedo;
- (void)saveContext;
- (void)updateAndReload;
- (void)fetchAndUpdate;
- (void)fetchUpdateAndReload;
- (void)rollbackAndReload;
@end
