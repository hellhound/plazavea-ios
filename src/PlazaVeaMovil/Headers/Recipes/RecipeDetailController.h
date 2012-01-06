#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/RecipeDetailDataSource.h"

@interface RecipeDetailController: BaseRecipeDetailController
        <RecipeDetailDataSourceDelegate>
{
    BOOL _hasMeat;
}
@end
