#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/TipsRecipeDetailController.h"

@implementation TipsRecipeDetailController

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
                section:kRecipeDetailTipsView from:_from] autorelease]];
}

#pragma mark -
#pragma mark BaseRecipeDetailController

- (id)initWithRecipeId:(NSString *)recipeId from:(NSString *)from
{
    if ((self = [super initWithRecipeId:recipeId from:from]) != nil) {
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

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
@end