#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableTableViewController.h"

@interface EditableTableViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end

@implementation EditableTableViewController (UITableViewDelegate)

#pragma mark -
#pragma mark EditableTableViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    if ((_allowsRowDeselection && ![self isEditing]) ||
            (_allowsRowDeselectionOnEditing && [self isEditing]))
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_performsSelectionAction)
        [self didSelectRowForObject:
                [_resultsController objectAtIndexPath:indexPath]
                    atIndexPath:indexPath];
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView indexPath:indexPath];
}

- (void)                        tableView:(UITableView *)tableView
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView indexPath:indexPath];
}

- (NSIndexPath *)               tableView:(UITableView *)tableView
 targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndex
                      toProposedIndexPath:(NSIndexPath *)proposedIndex
{
    // Allows moving cells
    return proposedIndex;
}
@end
