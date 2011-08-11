#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ReorderingManagedObject.h"
#import "Common/Controllers/EditableTableViewController.h"

@interface EditableTableViewController (UITableViewDataSource)
@end

@implementation EditableTableViewController (UITableViewDataSource)

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
    NSManagedObject *object =
            [_resultsController objectAtIndexPath:indexPath];
    Class cellClass = [self cellClassForObject:object atIndexPath:indexPath];
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    cell = [self cellForObject:object withCellClass:cellClass
            reuseCell:cell reuseIdentifier:reuseIdentifier
            atIndexPath:indexPath];
    return cell;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *object =
                [_resultsController objectAtIndexPath:indexPath];

        [_context deleteObject:object];
        [self fetchUpdateAndReload];
    }
}

- (BOOL)        tableView:(UITableView *)tableView
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Any value (or cell) can change order
    return [self allowsMovableCells];
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)fromIndex
          toIndexPath:(NSIndexPath *)toIndex
{
    NSManagedObject<ReorderingManagedObject> *from =
            [_resultsController objectAtIndexPath:fromIndex];
    NSManagedObject<ReorderingManagedObject> *to =
            [_resultsController objectAtIndexPath:toIndex];
    NSNumber *fromOrder = [from order];
    NSNumber *toOrder = [to order];

    [from setOrder:toOrder];
    [to setOrder:fromOrder];
    [self fetchAndUpdate];
}
@end
