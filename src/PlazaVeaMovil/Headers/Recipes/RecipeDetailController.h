#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface RecipeDetailController: BaseRecipeController
        <RecipeDetailDataSourceDelegate>
{
    NSString *_recipeId;
    TTImageView *_imageView;
    UIView *_headerView;
    UILabel *_titleLabel;
    UIBarButtonItem *_toListButton;
}

- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat;
- (id)initWithRecipeId:(NSString *)recipeId;
- (void)createShoppingListFormRecipe;
@end
