#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol RecipeDetailDataSourceDelegate;

@interface RecipeDetailDataSource: TTSectionedDataSource
{
    id<RecipeDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate;
@end

@protocol RecipeDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(RecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL;
@end
