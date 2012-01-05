#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/StoresTableViewDelegate.h"
#import "Stores/StoreDetailController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface StoreDetailController()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TTImageView *imageView;
@end

@implementation StoreDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_storeId release];
    [_headerView release];
    [_titleLabel release];
    [_imageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

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
    [self setImageView:[[[TTImageView alloc] initWithFrame:
            CGRectZero] autorelease]];
    [_imageView setDefaultImage:TTIMAGE(kStoreDetailDefaultImage)];
    [_imageView setAutoresizingMask:UIViewAutoresizingNone];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the label
    [self setTitleLabel:
        [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    // Adding the subviews to the header view
    if ([TTStyleSheet hasStyleSheetForSelector:
            @selector(storesBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(storesBackgroundHeader)] autorelease];
        [_headerView insertSubview:back atIndex:0];
    }
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:_imageView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0,
            boundsWidth, kStoreDetailImageHeight);
    CGRect imageFrame = CGRectMake((boundsWidth - kStoreDetailImageWidth) / 2.,
            .0, kStoreDetailImageWidth, kStoreDetailImageHeight);

    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
    [self refresh];
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if ([self toolbarItems] != nil) {
        for (UIBarButtonItem *item in [self toolbarItems]) {
            if ([[item customView] isKindOfClass:[UISegmentedControl class]]) {
                /*[(UISegmentedControl *)[item customView]
                  setTitle:kStoreDetailButtonLabel forSegmentAtIndex:0];*/
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
    [self setDataSource:[[[StoreDetailDataSource alloc]
            initWithStoreId:_storeId delegate:self] autorelease]];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[[StoresTableViewDelegate alloc] initWithController:self]
            autorelease];
}

#pragma mark -
#pragma mark StoreDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
    imageView = _imageView;

- (id)initWithStoreId:(NSString *)storeId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        _storeId = [storeId copy];
        [self setVariableHeightRows:YES];
    }
    return self;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            [[TTNavigator navigator] openURLAction:[[TTURLAction
                    actionWithURLPath:URL(kURLStoreDetailMapCall, _storeId, 
                        kStoreListTitle)] applyAnimated:YES]];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}

#pragma mark -
#pragma mark <StoreDetailDataSourceDelegate>

- (void)        dataSource:(StoreDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title
{
    if (title != nil) {
        // First we deal with the title
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
            [_titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
        }
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(headerColorYellow)]) {
            [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
        }
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
        
        if ((titleHeight + (margin * 2)) <= headerMinHeight) {
            titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
            titleHeight = headerMinHeight - (margin * 2);
        } else {
            titleFrame.origin.y += margin;
        }
        [_titleLabel setText:title];
        [_titleLabel setFrame:titleFrame];
        [_imageView setFrame:
         CGRectOffset(imageFrame, .0, titleHeight + (margin *2))];
        if (imageURL != nil)
            [_imageView setUrlPath:[imageURL absoluteString]];
        headerFrame.size.height += titleHeight + (margin *2); 
        [_headerView setFrame:headerFrame];
        [tableView setTableHeaderView:_headerView];
    }
}
@end
