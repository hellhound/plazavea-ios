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

static CGFloat margin = 5.;
static CGFloat categoryWidth = 150.;
static CGFloat headerMinHeight = 40.;

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

- (void)loadView
{
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
    [self setImageView:
            [[[TTImageView alloc] initWithFrame:CGRectZero] autorelease]];
    [_imageView setDefaultImage:TTIMAGE(kRecipeDetailDefaultImage)];
    [_imageView setAutoresizingMask:UIViewAutoresizingNone];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    // Conf the Cordon Bleu Logo
    TTImageView *logoView = [[[TTImageView alloc] initWithFrame:CGRectZero]
            autorelease];
    
    [logoView setDefaultImage:(UIImage*)TTSTYLE(cordonBleuLogo)];
    [logoView setBackgroundColor:[UIColor clearColor]];
    // Configuring the category label
    [self setCategoryLabel:
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
    [_categoryLabel setNumberOfLines:0];
    [_categoryLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_categoryLabel setTextAlignment:UITextAlignmentCenter];
    [_categoryLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [_categoryLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_categoryLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    // Configuring the name label
    [self setTitleLabel:
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentRight];
    [_titleLabel setShadowColor:[UIColor whiteColor]];
    [_titleLabel setShadowOffset:CGSizeMake(.0, 1.)];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(pictureHeaderFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(pictureHeaderFont)];
    }
    /*if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }*/
    [_titleLabel setTextColor:[UIColor blackColor]];
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(recipesBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(recipesBackgroundHeader)] autorelease];
        
        [_headerView insertSubview:back atIndex:0];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(recipePictureBackground)]) {
        _pictureBack = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(recipePictureBackground)] autorelease];
        
        [_headerView insertSubview:_pictureBack atIndex:1];
    }
    [_headerView addSubview:_imageView];
    [_headerView addSubview:_categoryLabel];
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:logoView];
    // Placing the views
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect categoryFrame =
            CGRectMake(0., margin, boundsWidth, headerMinHeight - (margin * 2));
    CGRect headerFrame = CGRectMake(.0, 0., boundsWidth,
            kRecipeDetailImageHeigth + headerMinHeight);
    CGRect imageFrame = CGRectMake(.0, headerMinHeight, kRecipeDetailImageWidth,
            kRecipeDetailImageHeigth);
    CGRect pictureFrame = CGRectMake(.0, headerMinHeight, boundsWidth, 
            kRecipeDetailImageHeigth);
    CGRect titleFrame = CGRectMake(boundsWidth - categoryWidth - (margin * 2),
            headerMinHeight, categoryWidth, kRecipeDetailImageHeigth);
    [logoView setFrame:CGRectOffset([logoView frame],
            boundsWidth - [logoView frame].size.width - margin, 40.)];
    
    [_categoryLabel setFrame:categoryFrame];
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [_pictureBack setFrame:pictureFrame];
    [_titleLabel setFrame:titleFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
    [self refresh];
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
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId hasMeat:(NSString *)hasMeat
{
    if ((self = [self initWithRecipeId:recipeId]) != nil) {
        if ([hasMeat boolValue]){
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

- (void)sizeTheHeaderWithImageURL:(NSURL *)imageURL
                         category:(NSString *)category
                         andTitle:(NSString *)title
{
    UITableView *tableView = [self tableView];
    // Setting the category
    UIFont *font = [_categoryLabel font];
    CGFloat labelWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedSize = CGSizeMake(labelWidth, MAXFLOAT);
    CGFloat labelHeight = [title sizeWithFont:font
            constrainedToSize:constrainedSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect categoryFrame = CGRectMake(.0, .0, labelWidth, labelHeight);
    
    if ((labelHeight + (margin * 2)) <= headerMinHeight) {
        categoryFrame.origin.y = (headerMinHeight - labelHeight) / 2;
        labelHeight = headerMinHeight - (margin * 2);
    } else {
        categoryFrame.origin.y += margin;
    }
    [_categoryLabel setText:title];
    [_categoryLabel setFrame:categoryFrame];
    // Setting the image
    CGRect imageFrame = [_imageView frame];
    CGRect backFrame = [_pictureBack frame];
    imageFrame.origin.y = backFrame.origin.y = labelHeight + (margin * 2);
    
    if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];
    [_imageView setFrame:imageFrame];
    [_pictureBack setFrame:backFrame];
    // Settings the title
    font = [_titleLabel font];
    constrainedSize = CGSizeMake(categoryWidth, MAXFLOAT);
    CGFloat categoryHeight = [category sizeWithFont:font
            constrainedToSize:constrainedSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = [_titleLabel frame];
    titleFrame.origin.y = backFrame.size.height + backFrame.origin.y -
            categoryHeight - (margin * 2.);
    titleFrame.size.height = categoryHeight;
    
    CGRect headerFrame = [_headerView frame];
    headerFrame.size.height = labelHeight + imageFrame.size.height +
            (margin * 2.);
    
    [_headerView setFrame:headerFrame];
    [_titleLabel setText:category];
    [_titleLabel setFrame:titleFrame];
    [_tableView setTableHeaderView:_headerView];
}
@end