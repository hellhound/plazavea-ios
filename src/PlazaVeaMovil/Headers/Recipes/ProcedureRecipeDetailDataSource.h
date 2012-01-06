#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol ProcedureRecipeDetailDataSourceDelegate;

@interface ProcedureRecipeDetailDataSource: TTListDataSource
{
    id<ProcedureRecipeDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<ProcedureRecipeDetailDataSourceDelegate>)delegate;
@end

@protocol ProcedureRecipeDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(ProcedureRecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                     title:(NSString *)title
               andCategory:(NSString *)category;
@end