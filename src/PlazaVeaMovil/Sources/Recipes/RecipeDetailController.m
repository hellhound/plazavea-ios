#import "math.h"
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
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation RecipeDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_recipeId release];
    [_imageView release];
    [_headerView release];
    [_titleLabel release];
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
#pragma mark UIView

- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [self tableView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            kRecipeDetailImageHeigth);
    CGRect imageFrame = CGRectMake((boundsWidth - kRecipeDetailImageWidth) / 2.,
            .0, kRecipeDetailImageWidth, kRecipeDetailImageHeigth);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[RecipeDetailDataSource alloc]
            initWithRecipeId:_recipeId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark RecipeController (Private)

@synthesize imageView = _imageView, headerView = _headerView,
        titleLabel = _titleLabel;

#pragma mark -
#pragma mark RecipeDetailController (Public)

- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat
{
    if ((self = [self initWithRecipeId:recipeId]) != nil) {
        if ([hasMeat boolValue]){
            [self setSegmentIndex:
                    kRecipesSegmentedControlIndexMeatButton];
        } else {
            [self setSegmentIndex:
                    kRecipesSegmentedControlIndexFoodButton];
        }
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:kRecipeDetailTitle];
        _recipeId = [recipeId copy];
        // Configuring the header view
        [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                autorelease]];
        // Configuring the image view
        [self setImageView:[[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0, kRecipeDetailImageWidth,
                    kRecipeDetailImageHeigth)] autorelease]];
        [_imageView setDefaultImage:TTIMAGE(kRecipeDetailDefaultImage)];
        [_imageView setAutoresizingMask:UIViewAutoresizingNone];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [_imageView setBackgroundColor:[UIColor clearColor]];
        // Configuring the label
        [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
                autorelease]];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [_titleLabel setTextAlignment:UITextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        // Adding the subviews to the header view
        [_headerView addSubview:_titleLabel];
        [_headerView addSubview:_imageView];
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
                  andTitle:(NSString *)title
{
    
    UITableView *tableView = [self tableView];
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
            lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect headerFrame = [_headerView frame];
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    CGRect imageFrame = [_imageView frame];
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    [_imageView setFrame:CGRectOffset(imageFrame, .0, titleHeight)];
    if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];
    headerFrame.size.height += titleHeight;
    [_headerView setFrame:headerFrame];
    [tableView setTableHeaderView:_headerView];
}
@end
