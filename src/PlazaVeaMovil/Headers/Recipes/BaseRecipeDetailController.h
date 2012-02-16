#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeController.h"

@interface BaseRecipeDetailController: BaseRecipeController
{
    NSString *_recipeId;
    TTImageView *_imageView;
    UIView *_headerView;
    UIView *_pictureBack;
    UILabel *_titleLabel;
    UILabel *_categoryLabel;
    UIBarButtonItem *_toListButton;
    kRecipeFromType _from;
}
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithRecipeId:(NSString *)recipeId;
- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat;
- (id)initWithRecipeId:(NSString *)recipeId from:(NSString *)from;
- (void)createShoppingListFormRecipe;
@end