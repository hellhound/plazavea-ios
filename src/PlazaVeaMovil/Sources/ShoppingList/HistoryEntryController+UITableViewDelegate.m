#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/HistoryEntryController.h"

static CGFloat margin = 5.;

@interface HistoryEntryController (UITableViewDelegate)

- (void)historyTableView:(UITableView *)tableView
               indexPath:(NSIndexPath *)indexPath;
@end

@implementation HistoryEntryController (UITableViewDelegate)

#pragma mark -
#pragma mark EditableTableViewController (UITableViewDelegate)

- (void)historyTableView:(UITableView *)tableView
               indexPath:(NSIndexPath *)indexPath
{
    if ((_allowsRowDeselection && ![self isEditing]) ||
            (_allowsRowDeselectionOnEditing && [self isEditing]))
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_performsSelectionAction)
        [self didSelectRowForObject:
                [_filteredController objectAtIndexPath:indexPath]
                    atIndexPath:indexPath];
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        [self historyTableView:tableView indexPath:indexPath];
    }
}

- (void)                        tableView:(UITableView *)tableView
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == [self tableView]) {
        [super tableView:tableView
                accessoryButtonTappedForRowWithIndexPath:indexPath];
    } else {
        [self historyTableView:tableView indexPath:indexPath];
    }
}

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingHistoryEntry *item = (ShoppingHistoryEntry *)[_resultsController
            objectAtIndexPath:indexPath];
    NSString *label = [item name];    
    CGSize constrainedSize = [tableView frame].size;
    constrainedSize.width -= (margin * 4);
    CGFloat cellHeight = [label sizeWithFont:[UIFont boldSystemFontOfSize:18.]
            constrainedToSize:constrainedSize
                lineBreakMode:UILineBreakModeWordWrap].height + (margin * 4);
    
    return cellHeight;
}
@end
