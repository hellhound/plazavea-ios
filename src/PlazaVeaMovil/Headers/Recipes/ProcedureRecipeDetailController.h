#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface ProcedureRecipeDetailController: BaseRecipeDetailController
        <RecipeDetailDataSourceDelegate>

@end