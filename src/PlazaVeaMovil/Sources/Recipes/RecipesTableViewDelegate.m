#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/StyleSheet.h"
#import "Recipes/RecipesTableViewDelegate.h"

@implementation RecipesTableViewDelegate

#pragma RecipeTableViewDelegate

@synthesize isMeat = _isMeat;

- (id)initWithController:(TTTableViewController *)controller isMeat:(BOOL)isMeat
{
    if ((self = [self initWithController:controller]) != nil)
        _isMeat = isMeat;
    return self;
}

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
    
    if (_isMeat) {
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(meatsSectionHeader)]) {
            [header setStyle:TTSTYLE(meatsSectionHeader)];
        }
    } else {
        if ([TTStyleSheet hasStyleSheetForSelector:
             @selector(recipesSectionHeader)]) {
            [header setStyle:TTSTYLE(recipesSectionHeader)];
        }
    }
    return header;
}
@end