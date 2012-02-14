#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/RecipeDrillDownController.h"

@interface RecipeListController: RecipeDrillDownController
{
    NSString *_collectionId;
    BOOL _isMeat;
    BOOL _isWine;
    kRecipeFromType _from;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, readonly) NSString *collectionId;
@property (nonatomic, readonly) BOOL isMeat;
@property (nonatomic, readonly) BOOL isWine;
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithCategoryId:(NSString *)categoryId name:(NSString *)name;
- (id)initWithMeatId:(NSString *)meatId name:(NSString *)name;
- (id)initWithWineId:(NSString *)wineId name:(NSString *)name;
@end
