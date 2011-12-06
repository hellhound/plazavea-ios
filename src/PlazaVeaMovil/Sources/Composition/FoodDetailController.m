#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Composition/Constants.h"
#import "Composition/FoodDetailDataSource.h"
#import "Composition/FoodDetailController.h"

static CGFloat margin = 5.;
static CGFloat categoryWidth = 120.;
static CGFloat headerMinHeight = 40.;

@interface FoodDetailController ()

@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation FoodDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_food release];
    [_imageView release];
    [_headerView release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (void)loadView
{
    [super loadView];

    UITableView *tableView = [self tableView];
    
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
            autorelease]];
    // Configuring the image view
    [self setImageView:[[[TTImageView alloc] initWithFrame:
            CGRectMake(.0, .0, kFoodDetailImageWidth,
                kFoodDetailImageHeight)] autorelease]];
    [_imageView setDefaultImage:TTIMAGE(kFoodDetailDefaultImage)];
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
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    NSString *title = kFoodCategoryHeader;
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
        titleHeight = headerMinHeight - (margin * 2);
    } else {
        titleFrame.origin.y += margin;
    }
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(compositionBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(compositionBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(compositionPictureBackground)]) {
        UIImageView *pictureBack = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(compositionPictureBackground)] autorelease];
        CGRect backFrame = [pictureBack frame];
        backFrame.origin.y = MAX(titleHeight + (2 * margin), 40.);
        [pictureBack setFrame:backFrame];
        [_headerView insertSubview:pictureBack atIndex:1];
    }
    
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:_imageView];
    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth, kFoodDetailImageHeight
            + titleHeight + (2 * margin));
    CGRect imageFrame = CGRectMake(1.0, .0, kFoodDetailImageWidth,
            kFoodDetailImageHeight);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:
            CGRectOffset(imageFrame, .0, titleHeight + (2 * margin))];
    UILabel *categoryLabel =
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [categoryLabel setNumberOfLines:0];
    [categoryLabel setLineBreakMode:UILineBreakModeWordWrap];
    [categoryLabel setTextAlignment:UITextAlignmentRight];
    [categoryLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
         hasStyleSheetForSelector:@selector(pictureHeaderFont)]) {
        [categoryLabel setFont:(UIFont *)TTSTYLE(pictureHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [categoryLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    NSString *category = [[_food category] name];
    UIFont *categoryFont = [categoryLabel font];
    CGSize constrainedCategorySize = CGSizeMake(categoryWidth, MAXFLOAT);
    CGFloat categoryHeight = [category sizeWithFont:categoryFont
            constrainedToSize:constrainedCategorySize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGFloat categoryY = headerFrame.size.height - categoryHeight - margin;
    CGRect categoryFrame = CGRectMake((boundsWidth - categoryWidth - margin),
            categoryY, categoryWidth, categoryHeight);
    
    [categoryLabel setText:category];
    [categoryLabel setFrame:categoryFrame];
    [_headerView addSubview:categoryLabel];
    /*if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];*/
    [tableView setTableHeaderView:_headerView];
    [self refresh];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[FoodDetailDataSource alloc] initWithFood:_food] autorelease]];
}

#pragma mark -
#pragma mark RecipeController (Private)

@synthesize imageView = _imageView, headerView = _headerView,
        titleLabel = _titleLabel;

#pragma mark -
#pragma mark FoodDetailController

- (id) initWithFood:(Food *)food
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
        _food = food;
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
    }
    return self;
}
@end