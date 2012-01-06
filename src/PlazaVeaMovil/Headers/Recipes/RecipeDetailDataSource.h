#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol RecipeDetailDataSourceDelegate;

@interface RecipeDetailDataSource: TTListDataSource
{
    id<RecipeDetailDataSourceDelegate> _delegate;
    BOOL _hasMeat;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate;
- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               hasMeat:(BOOL)hasMeat;
@end

@protocol RecipeDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(RecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                     title:(NSString *)title
               andCategory:(NSString *)category;
@end