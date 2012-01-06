#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/IngredientRecipeDetailDataSource.h"

@interface IngredientRecipeDetailController: BaseRecipeDetailController
        <IngredientRecipeDetailDataSourceDelegate>

@end