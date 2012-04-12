#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/RecipeDetailController.h"

@implementation RecipeDetailController

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    [[self navigationController] setToolbarHidden:YES];
    return [super navigationItem];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[RecipeDetailDataSource alloc]
            initWithRecipeId:_recipeId delegate:self
                section:kRecipeDetailMainView from:_from] autorelease]];
}

#pragma mark -
#pragma mark BaseRecipeDetailController

- (void)createShoppingListFormRecipe
{
    ShoppingList *shopingList = [(Recipe *)[self model] createShoppingList];
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:nil 
            message:[NSString stringWithFormat:kRecipeDetailCreateMessage,
                [shopingList name]] delegate:self
                cancelButtonTitle:kRecipeDetailCreateButton
                otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark RecipeDetailController

- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat
{
    if ((self = [self initWithRecipeId:recipeId]) != nil) {
        _hasMeat = [hasMeat boolValue];
        if ([hasMeat boolValue]) {
            [self setSegmentIndex:kRecipesSegmentedControlIndexMeatButton];
        } else {
            [self setSegmentIndex:kRecipesSegmentedControlIndexFoodButton];
        }
    }
    return self;
}

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)dataSource:(RecipeDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end