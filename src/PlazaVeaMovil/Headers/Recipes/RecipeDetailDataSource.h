#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"

@protocol RecipeDetailDataSourceDelegate;

@interface RecipeDetailDataSource: TTSectionedDataSource
{
    id<RecipeDetailDataSourceDelegate> _delegate;
    BOOL _hasMeat;
    RecipeDetailViewType _section;
    kRecipeFromType _from;
}
@property (nonatomic, readonly) id delegate;
@property (nonatomic, assign) RecipeDetailViewType section;
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate;
- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               hasMeat:(BOOL)hasMeat;
- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               section:(RecipeDetailViewType)section
                  from:(kRecipeFromType)from;
- (UIView *)viewWithImageURL:(NSString *)imageURL
                       title:(NSString *)title
                      detail:(NSString *)detail;
@end

@protocol RecipeDetailDataSourceDelegate <NSObject>

- (void)dataSource:(RecipeDetailDataSource *)dataSource
        viewForHeader:(UIView *)view;
@end