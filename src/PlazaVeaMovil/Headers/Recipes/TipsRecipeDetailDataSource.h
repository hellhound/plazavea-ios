#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol TipsRecipeDetailDataSourceDelegate;

@interface TipsRecipeDetailDataSource: TTListDataSource
{
    id<TipsRecipeDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<TipsRecipeDetailDataSourceDelegate>)delegate;
@end

@protocol TipsRecipeDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(TipsRecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                     title:(NSString *)title
               andCategory:(NSString *)category;
@end