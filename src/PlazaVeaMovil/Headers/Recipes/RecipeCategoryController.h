#import <Foundation/Foundation.h>

#import "Recipes/BaseRecipeController.h"

@interface RecipeCategoryController: BaseRecipeController
{
    NSString *_categoryId;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, copy) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end
