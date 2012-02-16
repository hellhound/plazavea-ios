#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface TipsRecipeDetailController: BaseRecipeDetailController
        <RecipeDetailDataSourceDelegate>

@end