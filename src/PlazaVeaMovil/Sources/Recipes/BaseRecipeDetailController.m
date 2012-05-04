#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/BaseRecipeDetailController.h"

@interface BaseRecipeDetailController ()

@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *pictureBack;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *categoryLabel;
@end

@implementation BaseRecipeDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_recipeId release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if (_toListButton == nil) {
        _toListButton = [[UIBarButtonItem alloc]
                initWithTitle:NSLocalizedString(
                    kRecipeDetailToListButtonTitle, nil)
                    style:UIBarButtonItemStylePlain target:self
                    action:@selector(createShoppingListFormRecipe)];
        
        [navItem setRightBarButtonItem:_toListButton];
    }
    return navItem;
}

#pragma mark -
#pragma mark BaseRecipeDetailController (Private)

@synthesize imageView = _imageView, headerView = _headerView,
        titleLabel = _titleLabel, categoryLabel = _categoryLabel,
            pictureBack = _pictureBack, from = _from;

#pragma mark -
#pragma mark BaseRecipeDetailController (Public)

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:kRecipeDetailTitle];
        
        _recipeId = [recipeId copy];
        
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat
{
    if ((self = [self initWithRecipeId:recipeId]) != nil) {
        if ([hasMeat boolValue]) {
            [self setSegmentIndex:kRecipesSegmentedControlIndexMeatButton];
        } else {
            [self setSegmentIndex:kRecipesSegmentedControlIndexFoodButton];
        }
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId from:(NSString *)from
{
    if ((self = [self initWithRecipeId:recipeId]) != nil) {
        _from = [from integerValue];
    }
    return self;
}

- (void)createShoppingListFormRecipe
{
    // Override
}

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)dataSource:(RecipeDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end