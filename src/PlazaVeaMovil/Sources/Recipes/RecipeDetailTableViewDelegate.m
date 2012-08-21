#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/StyleSheet.h"
#import "Recipes/RecipeDetailTableViewDelegate.h"

@implementation RecipeDetailTableViewDelegate

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section
{
    CGFloat height= [TTStyleSheet hasStyleSheetForSelector:
            @selector(heightForTableSectionHeaderView)] ?
                TTSTYLEVAR(heightForTableSectionHeaderView) : .0;
    return height;
}

- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section
{
    TTView *header = (TTView *)[super tableView:tableView
            viewForHeaderInSection:section];
    
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(recipesSectionHeader)]) {
        [header setStyle:TTSTYLE(recipesSectionHeader)];
    }
    return header;
}
@end