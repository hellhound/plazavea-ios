#import <Foundation/Foundation.h>

#import "Recipes/RecipeDrillDownController.h"

@interface RecipeCategoryController: RecipeDrillDownController
{
    NSString *_categoryId;
}
@property (nonatomic, copy) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end
