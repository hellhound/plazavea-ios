#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Stores/StoresTableViewDelegate.h"

@implementation StoresTableViewDelegate

#pragma mark -
#pragma mark UITableViewDelegate

- (UIView *)    tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section
{
    TTView *header = (TTView *)[super tableView:tableView
            viewForHeaderInSection:section];
    [header setStyle:TTSTYLE(storesSectionHeader)];
    return header;
}

@end