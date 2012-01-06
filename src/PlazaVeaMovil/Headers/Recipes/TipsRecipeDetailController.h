#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/TipsRecipeDetailDataSource.h"

@interface TipsRecipeDetailController: BaseRecipeDetailController
        <TipsRecipeDetailDataSourceDelegate>

@end