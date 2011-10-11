#import <Foundation/Foundation.h>

#import "Recipes/BaseRecipeController.h"

@interface RecipeCategoryController: BaseRecipeController
{
    NSString *_categoryId;
}
@property (nonatomic, copy) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end
