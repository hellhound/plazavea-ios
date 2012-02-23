#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/HistoryEntryController.h"

@interface HistoryEntryController (UITableViewDataSource)
@end

@implementation HistoryEntryController (UITableViewDataSource)

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
    if (tableView == [self tableView]) {
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        // TODO we need to optimize the reuseIdentifier, it should be defined
        // once
        NSManagedObject *object = [_filteredController
                objectAtIndexPath:indexPath];
        Class cellClass = [self cellClassForObject:object atIndexPath:indexPath];
        NSString *reuseIdentifier = NSStringFromClass(cellClass);
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell = [self cellForObject:object withCellClass:cellClass
                reuseCell:cell reuseIdentifier:reuseIdentifier
                    atIndexPath:indexPath];
        
        [self didCreateCell:cell forObject:object atIndexPath:indexPath];
    }
    return cell;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView commitEditingStyle:editingStyle
                forRowAtIndexPath:indexPath];
    } else if (editingStyle == UITableViewCellEditingStyleDelete) {
            NSManagedObject *object =
                    [_filteredController objectAtIndexPath:indexPath];

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
    if (tableView == [self tableView]) {
        [super tableView:tableView moveRowAtIndexPath:fromIndex
                toIndexPath:toIndex];
    } else {
        NSManagedObject<ReorderingManagedObject> *from =
                [_filteredController objectAtIndexPath:fromIndex];
        NSManagedObject<ReorderingManagedObject> *to =
                [_filteredController objectAtIndexPath:toIndex];
        NSNumber *fromOrder = [from order];
        NSNumber *toOrder = [to order];

        [from setOrder:toOrder];
        [to setOrder:fromOrder];
        [self fetchAndUpdate];
    }
}
@end
