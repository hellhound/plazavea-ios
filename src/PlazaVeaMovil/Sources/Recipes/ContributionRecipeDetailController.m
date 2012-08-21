#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/ContributionRecipeDetailController.h"
#import "Recipes/RecipeDetailTableViewDelegate.h"

@implementation ContributionRecipeDetailController

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
                section:kRecipeDetailContributionView from:_from] autorelease]];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[[RecipeDetailTableViewDelegate alloc] initWithController:self]
            autorelease];
}

- (void)createShoppingListFormRecipe
{
    ShoppingList *shopingList = [(Recipe *)[self model] createShoppingList];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
            message:[NSString stringWithFormat:kRecipeDetailCreateMessage,
                [shopingList name]] delegate:self
                cancelButtonTitle:kRecipeDetailCreateButton
                otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
}
@end