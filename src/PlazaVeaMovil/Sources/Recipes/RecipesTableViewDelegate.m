#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/StyleSheet.h"
#import "Recipes/Constants.h"
#import "Recipes/RecipesTableViewDelegate.h"

@implementation RecipesTableViewDelegate

#pragma RecipeTableViewDelegate

@synthesize from = _from;

- (id)initWithController:(TTTableViewController *)controller
                    from:(kRecipeFromType)from
{
    if ((self = [self initWithController:controller]) != nil)
        _from = from;
    return self;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    
    switch (_from) {
        case kRecipeFromCategory:
        case kRecipeFromMeat:
            height = [TTStyleSheet hasStyleSheetForSelector:
                    @selector(heightForTableSectionHeaderView)] ?
                        TTSTYLEVAR(heightForTableSectionHeaderView) : .0;
            break; 
        case kRecipeFromWine:
        default:
            height = .0;t
            break;
    }
    return height;
}

- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section
{
    TTView *header = (TTView *)[super tableView:tableView
            viewForHeaderInSection:section];
    
    switch (_from) {
        case kRecipeFromCategory:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(recipesSectionHeader)]) {
                [header setStyle:TTSTYLE(recipesSectionHeader)];
            }
            break;
        case kRecipeFromMeat:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(meatsSectionHeader)]) {
                [header setStyle:TTSTYLE(meatsSectionHeader)];
            }
            break;
        case kRecipeFromWine:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(wineSectionHeader)]) {
                [header setStyle:TTSTYLE(wineSectionHeader)];
            }
            break;
        default:
            break;
    }
    
    return header;
}
@end