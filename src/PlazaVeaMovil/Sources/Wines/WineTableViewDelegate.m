#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/StyleSheet.h"
#import "Wines/WineTableViewDelegate.h"

@implementation WineTableViewDelegate

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section
{
    return [TTStyleSheet hasStyleSheetForSelector:
            @selector(heightForTableSectionHeaderView)] ?
    TTSTYLEVAR(heightForTableSectionHeaderView) : .0;
}

- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section
{
    TTView *header = (TTView *)[super tableView:tableView
            viewForHeaderInSection:section];
    
    if ([TTStyleSheet hasStyleSheetForSelector:
         @selector(storesSectionHeader)]) {
        [header setStyle:TTSTYLE(wineSectionHeader)];
    }
    return header;
}
@end