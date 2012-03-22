#import <Foundation/Foundation.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Constants.h"
#import "Offers/Constants.h"
#import "Offers/OfferListDataSource.h"
#import "Offers/OfferListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@implementation OfferListController

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
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectZero]
            autorelease];
    // Conf the banner
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kOfferBannerDefaultImage)] autorelease];
    
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the label
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorYellow)]) {
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    }
    
    NSString *title = [self title];
    UIFont *font = [titleLabel font];
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
    
    [titleLabel setText:title];
    [titleLabel setFrame:titleFrame];
    
    CGRect imageFrame = [imageView frame];
    imageFrame.origin.y += titleHeight + (margin * 2.);
    
    [imageView setFrame:imageFrame];
    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            titleHeight + imageFrame.size.height + (2 * margin));
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(offerBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(offerBackgroundHeader)] autorelease];
        [headerView insertSubview:back atIndex:0];
    }
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    [headerView setFrame:headerFrame];
    [headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:headerView];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kOfferListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[OfferListDataSource alloc] init] autorelease]];
}
@end