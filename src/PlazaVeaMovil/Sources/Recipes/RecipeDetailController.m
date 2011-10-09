#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/RecipeDetailController.h"

@interface RecipeDetailController ()

@property (nonatomic, retain) TTImageView *imageView;
@end

@implementation RecipeDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_recipeId release];
    [_imageView release];
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
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[RecipeDetailDataSource alloc]
            initWithRecipeId:_recipeId delegate:self] autorelease]];
}

- (void)didShowModel:(BOOL)firstTime
{
    if (firstTime) {
        [_imageView setDefaultImage:TTIMAGE(kRecipeDetailDefaultImage)];
        [_imageView setAutoresizingMask:UIViewAutoresizingNone];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [super didShowModel:firstTime];

        UITableView *tableView = [self tableView];
        CGRect bounds = [tableView bounds];
        UIView *headerView = [[[UIView alloc] initWithFrame:
                CGRectMake((bounds.size.width - kRecipeDetailImageWidth) / 2.,
                        .0,60.,
                        60.)] autorelease];

        [headerView addSubview:_imageView];
        [tableView setTableHeaderView:headerView];
    }
}

#pragma mark -
#pragma mark RecipeController (Private)

@synthesize imageView = _imageView;

#pragma mark -
#pragma mark RecipeDetailController (Public)

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:kRecipeDetailTitle];
        _recipeId = [recipeId copy];
        [self setImageView:[[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0, 60., 60.)] autorelease]];
    }
    return self;
}

- (void)createShoppingListFormRecipe
{
    ShoppingList *shopingList = [(Recipe *)[self model] createShoppingList];
    UIAlertView *alertView =[[UIAlertView alloc]
        initWithTitle:nil 
            message:[NSString stringWithFormat:kRecipeDetailCreateMessage,
                [shopingList name]] delegate:self
                cancelButtonTitle:kRecipeDetailCreateButton
            otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)        dataSource:(RecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
{
    [_imageView setUrlPath:[imageURL absoluteString]];
}
@end
