#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/BaseRecipeDetailController.h"
#import "Recipes/ProcedureRecipeDetailDataSource.h"

@interface ProcedureRecipeDetailController: BaseRecipeDetailController
        <ProcedureRecipeDetailDataSourceDelegate>

@end