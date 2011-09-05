#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/RecipeDrillDownController.h"

@interface RecipeListController: RecipeDrillDownController
{
    NSString *_categoryId;
}
@property (nonatomic, readonly) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end
