#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/RecipeDrillDownController.h"

@interface RecipeListController: RecipeDrillDownController
{
    NSString *_collectionId;
    BOOL _isMeat;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, readonly) NSString *collectionId;
@property (nonatomic, readonly) BOOL isMeat;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithMeatId:(NSString *)meatId;
@end
