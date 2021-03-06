#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/RecipeDrillDownController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface BaseRecipeController: RecipeDrillDownController
        <RecipeDetailDataSourceDelegate>
@end
