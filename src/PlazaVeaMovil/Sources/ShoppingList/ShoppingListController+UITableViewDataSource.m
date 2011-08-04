#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UITableViewDataSource)
@end

@implementation ShoppingListController (UITableViewDataSource)

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

    NSDate *date = [list lastModificationDate];

    [[cell detailTextLabel] setText:date == nil ||
            [date isEqual:[NSNull null]] ?
            kShoppingListDefaultDetailText :
            [dateFormatter stringFromDate:date]];
    return cell;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [_appDelegate context];
        ShoppingList *list = [_resultsController objectAtIndexPath:indexPath];

        [context deleteObject:list];
        [self updateUndoRedo];
        [tableView reloadData];
    }
}

- (BOOL)        tableView:(UITableView *)tableView
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Any value (or cell) can change order
    return YES;
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)fromIndex
          toIndexPath:(NSIndexPath *)toIndex
{
    ShoppingList *from = [_resultsController objectAtIndexPath:fromIndex];
    ShoppingList *to = [_resultsController objectAtIndexPath:toIndex];
    NSNumber *fromOrder = [from order];
    NSNumber *toOrder = [to order];

    [from setOrder:toOrder];
    [to setOrder:fromOrder];
    [self performFetch];
    [self updateUndoRedo];
}
@end
