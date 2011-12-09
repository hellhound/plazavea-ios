#import <Foundation/Foundation.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/StoresTableViewDelegate.h"
#import "Stores/StoreListDataSource.h"
#import "Stores/StoreListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface StoreListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation StoreListController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_headerView release];
    [_titleLabel release];
    [_regionId release];
    [_subregionId release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [self setTitle:kStoreListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

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
            @selector(emergencyBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(storesBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if ([self toolbarItems] != nil) {
        for (UIBarButtonItem *item in [self toolbarItems]) {
            if ([[item customView] isKindOfClass:[UISegmentedControl class]]) {
                [(UISegmentedControl *)[item customView] addTarget:self
                        action:@selector(switchControllers:)
                            forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StoreListDataSource alloc]
            initWithSubregionId:_subregionId andRegionId:_regionId]
                autorelease]];
}


- (id<UITableViewDelegate>)createDelegate {
    return [[[StoresTableViewDelegate alloc] initWithController:self]
            autorelease];
}

#pragma mark -
#pragma mark StoreListController (Public)

@synthesize subregionId = _subregionId, regionId = _regionId,
        titleLabel = _titleLabel, headerView = _headerView;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        _subregionId = [subregionId copy];
        _regionId = [regionId copy];
    }
    return self;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            NSArray *viewControllers = [(UINavigationController *)
                    [self parentViewController] viewControllers];
            NSString *buttonTitle = [[viewControllers objectAtIndex:
                    ([viewControllers count] - 2)] title];
            [[TTNavigator navigator] openURLAction:[[TTURLAction
                    actionWithURLPath:URL(kURLStoreMapCall, _subregionId,
                        _regionId, buttonTitle)] applyAnimated:YES]];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}
@end
