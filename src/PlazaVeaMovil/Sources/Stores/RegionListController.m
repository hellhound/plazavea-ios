#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Stores/Constants.h"
#import "Stores/RegionListDataSource.h"
#import "Stores/SubregionDataSource.h"
#import "Stores/RegionListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface RegionListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation RegionListController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_headerView release];
    [_titleLabel release];
    [_regionId release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
            @selector(storesBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(storesBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [self setTitle:kRegionListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if (_regionId != nil) {
        [self setDataSource:[[[SubregionDataSource alloc]
                initWithRegionId:_regionId] autorelease]];
    } else {
        [self setDataSource:[[[RegionListDataSource alloc] init] autorelease]];
    }
}

#pragma mark -
#pragma mark RegionListController (Public)

@synthesize regionId = _regionId, headerView = _headerView,
        titleLabel = _titleLabel;

- (id)initWithRegionId:(NSString *)regionId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        _regionId = [regionId copy];
        [self setTitle:kSubregionListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}
@end
