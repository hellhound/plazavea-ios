#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/BaseRecipeController.h"

@implementation BaseRecipeController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setSegmentIndex:kRecipesSegmentedControlIndexFoodButton];
    return self;
}

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)dataSource:(RecipeDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    
}
@end
