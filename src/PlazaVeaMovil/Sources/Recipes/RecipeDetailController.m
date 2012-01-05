#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/RecipeDetailDataSource.h"
#import "Recipes/RecipeDetailController.h"

static CGFloat margin = 5.;
static CGFloat categoryWidth = 120.;
static CGFloat headerMinHeight = 40.;

@interface RecipeDetailController ()

@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *categoryLabel;
@end

@implementation RecipeDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_recipeId release];
    [_imageView release];
    [_headerView release];
    [_categoryLabel release];
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

- (void)loadView
{
    /*[super loadView];
    
    UITableView *tableView = [self tableView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            kRecipeDetailImageHeigth);
    CGRect imageFrame = CGRectMake((boundsWidth - kRecipeDetailImageWidth) / 2.,
            .0, kRecipeDetailImageWidth, kRecipeDetailImageHeigth);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [tableView setTableHeaderView:_headerView];
    [self refresh];*/
    [super loadView];
    [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
    
    UITableView *tableView = [self tableView];
    [self setHeaderView:
     [[[UIView alloc] initWithFrame:CGRectZero] autorelease]];
    // Configuring the image view
    [self setImageView:[[[TTImageView alloc] initWithFrame:
            CGRectZero] autorelease]];
    [_imageView setDefaultImage:TTIMAGE(kRecipeDetailDefaultImage)];
    [_imageView setAutoresizingMask:UIViewAutoresizingNone];
    /*[_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];*/
    [_imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the category label
    [self setCategoryLabel:
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
    [_categoryLabel setNumberOfLines:0];
    [_categoryLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_categoryLabel setTextAlignment:UITextAlignmentCenter];
    [_categoryLabel setBackgroundColor:[UIColor clearColor]];
    // Configuring the name label
    [self setTitleLabel:
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentRight];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(pictureHeaderFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(pictureHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(recipesBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(recipesBackgroundHeader)] autorelease];
        
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_categoryLabel];
    [_headerView addSubview:_imageView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake
            (.0, .0, boundsWidth, kRecipeDetailImageHeigth);
    CGRect imageFrame = CGRectMake
            (.0, .0, kRecipeDetailImageWidth, kRecipeDetailImageHeigth);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
    [self refresh];
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
        titleLabel = _titleLabel, categoryLabel = _categoryLabel;

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
        /*
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
        [_headerView addSubview:_imageView];*/
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
                     title:(NSString *)title
               andCategory:(NSString *)category
{
    /*UITableView *tableView = [self tableView];
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
    [tableView setTableHeaderView:_headerView];*/
    if (title != nil && category != nil) {
        // First we deal with the title
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
            [_categoryLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
        }
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(headerColorWhite)]) {
            [_categoryLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
        }
        UITableView *tableView = [self tableView];
        UIFont *font = [_categoryLabel font];
        CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
        CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
        CGFloat titleHeight = [category sizeWithFont:font
                constrainedToSize:constrainedTitleSize
                    lineBreakMode:UILineBreakModeWordWrap].height;
        CGRect headerFrame = [_headerView frame];
        CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
        CGRect imageFrame = [_imageView frame];
        
        if ((titleHeight + (margin * 2)) <= headerMinHeight) {
            titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
            titleHeight = headerMinHeight - (margin * 2);
        } else {
            titleFrame.origin.y += margin;
        }
        UIImageView *pictureBack;
        
        if ([TTStyleSheet hasStyleSheetForSelector:
             @selector(recipePictureBackground)]) {
            pictureBack = [[[UIImageView alloc] initWithImage:
                            (UIImage *)TTSTYLE(recipePictureBackground)] autorelease];
            
            [_headerView insertSubview:pictureBack atIndex:1];
        }
        CGRect pictureBackFrame = [pictureBack frame];
        pictureBackFrame.origin.y = titleHeight + (margin * 2);
        
        [pictureBack setFrame:pictureBackFrame];
        [_categoryLabel setText:category];
        [_categoryLabel setFrame:titleFrame];
        [_imageView setFrame:
                CGRectOffset(imageFrame, .0, titleHeight + (margin * 2))];
        if (imageURL != nil)
            [_imageView setUrlPath:[imageURL absoluteString]];
        headerFrame.size.height += titleHeight + (margin * 2); 
        
        font = [_titleLabel font];
        constrainedTitleSize = CGSizeMake(categoryWidth, MAXFLOAT);
        titleHeight = [title sizeWithFont:font
                constrainedToSize:constrainedTitleSize
                    lineBreakMode:UILineBreakModeWordWrap].height;
        CGFloat titleY = headerFrame.size.height - titleHeight - margin;
        CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
        titleFrame = CGRectMake((boundsWidth - categoryWidth - margin),
                    titleY, categoryWidth, titleHeight);
        
        [_titleLabel setText:title];
        [_titleLabel setFrame:titleFrame];
        [_headerView addSubview:_titleLabel];
        [_headerView setFrame:headerFrame];
        [tableView setTableHeaderView:_headerView];
    }
}
@end