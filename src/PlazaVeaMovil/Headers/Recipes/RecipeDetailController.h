#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface RecipeDetailController: ReconnectableTableViewController
        <RecipeDetailDataSourceDelegate>
{
    NSString *_recipeId;
    TTImageView *_imageView;
    UIBarButtonItem *_toListButton;
}

- (id)initWithRecipeId:(NSString *)recipeId;
- (void)createShoppingListFormRecipe;
@end
