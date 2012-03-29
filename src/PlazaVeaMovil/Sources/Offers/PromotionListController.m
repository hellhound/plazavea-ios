#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/UIDevice+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Launcher/Constants.h"
#import "Offers/Constants.h"
#import "Offers/PromotionListDataSource.h"
#import "Offers/PromotionListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface PromotionListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation PromotionListController

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
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorYellow)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerShadowColor)]) {
        [_titleLabel setShadowColor:(UIColor *)TTSTYLE(headerShadowColor)];
        [_titleLabel setShadowOffset:CGSizeMake(.0, -1.)];
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
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
                                    titleHeight + (2 * margin));
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
         @selector(offerBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                              (UIImage *)TTSTYLE(offerBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:NSLocalizedString(kPromotionListTitle, nil)];
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    if (_backButton == nil) {
        _backButton = [[UIBarButtonItem alloc]
                initWithTitle:NSLocalizedString(
                    kLauncherTitle, nil)
                    style:UIBarButtonItemStylePlain target:self
                    action:@selector(popToNavigationWindow)];
        [navItem setLeftBarButtonItem:_backButton];
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[PromotionListDataSource alloc] init] autorelease]];
}

#pragma mark -
#pragma mark PromotionListController

@synthesize titleLabel = _titleLabel, headerView = _headerView;

- (void)popToNavigationWindow
{
    [self dismissModalViewControllerAnimated:YES];
    if ([[UIDevice currentDevice] deviceSystemVersion] > kSystemVersion4) {
        [(UINavigationController *)
                [[self parentViewController] performSelector:
                    @selector(presentingViewController)]
                    popToRootViewControllerAnimated:NO];
    } else {
        [(UINavigationController *)
                [[self parentViewController] parentViewController]
                    popToRootViewControllerAnimated:NO];
    }
}
@end
