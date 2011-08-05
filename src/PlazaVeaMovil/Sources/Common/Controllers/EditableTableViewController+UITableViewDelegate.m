#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UITableViewDelegate)
@end

@implementation ShoppingListController (UITableViewDelegate)

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((_allowsRowDeselection && ![self isEditing]) ||
            (_allowsRowDeselectionOnEditing && [self isEditing]))
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_performsSelectionAction)
        [self didSelectRowForObject:
                [_resultsController objectAtIndexPath:indexPath]
                    atIndexPath:indexPath];
}

- (NSIndexPath *)               tableView:(UITableView *)tableView
 targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndex
                      toProposedIndexPath:(NSIndexPath *)proposedIndex
{
    // Allows moving cells
    return proposedIndex;
}
@end