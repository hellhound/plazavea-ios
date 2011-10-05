#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
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

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)        dataSource:(RecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
{
    [_imageView setUrlPath:[imageURL absoluteString]];
}
@end
