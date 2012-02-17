#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Constants.h"
#import "Recipes/RecipeCategoryDataSource.h"
#import "Recipes/RecipeCategoryController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface RecipeCategoryController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation RecipeCategoryController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_headerView release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
    UITableView *tableView = [self tableView];
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
            autorelease]];
    // Conf the banner
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kRecipeCategoryImage)] autorelease];
    
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
     UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
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
    
    NSString *title = [self title];
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
    CGRect imageFrame = [imageView frame];
    imageFrame.origin.y += titleHeight + (margin * 2.);
    [imageView setFrame:imageFrame];
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            titleHeight + imageFrame.size.height + (2 * margin));
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(recipesBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(recipesBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView setFrame:headerFrame];
    [_headerView addSubview:imageView];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:NSLocalizedString(kRecipeCategoryTitle, nil)];
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if (_categoryId == nil) {
        [self setDataSource:
                [[[RecipeCategoryDataSource alloc] init] autorelease]];
    }
    else {
        [self setDataSource:[[[RecipeCategoryDataSource alloc]
                initWithCategoryId:_categoryId] autorelease]];
    }
}

#pragma mark -
#pragma mark RecipeCategoryController (Public)

@synthesize categoryId = _categoryId, headerView = _headerView,
        titleLabel = _titleLabel;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil){
        _categoryId = [categoryId copy];
        [self setTitle:NSLocalizedString(kRecipeSubcategoryTitle, nil)];
    }
    return self;
}
@end
