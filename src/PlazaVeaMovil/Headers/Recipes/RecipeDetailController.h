#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface RecipeDetailController: BaseRecipeController
        <RecipeDetailDataSourceDelegate>
{
    NSString *_recipeId;
    TTImageView *_imageView;
    UIBarButtonItem *_toListButton;
}

- (id)initWithRecipeId:(NSString *)recipeId;
- (void)createShoppingListFormRecipe;
@end
