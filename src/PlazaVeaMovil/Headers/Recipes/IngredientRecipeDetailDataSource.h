#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol IngredientRecipeDetailDataSourceDelegate;

@interface IngredientRecipeDetailDataSource: TTListDataSource
{
    id<IngredientRecipeDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<IngredientRecipeDetailDataSourceDelegate>)delegate;
@end

@protocol IngredientRecipeDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(IngredientRecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                     title:(NSString *)title
               andCategory:(NSString *)category;
@end