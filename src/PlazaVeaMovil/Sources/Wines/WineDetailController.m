#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WineDetailController.h"

@interface WineDetailController()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TTImageView *imageView;

@end

@implementation WineDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_wineId release];
    [_headerView release];
    [_footerView release];
    [_titleLabel release];
    [_imageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

/*- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [self tableView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect footerFrame =
            CGRectMake(.0, .0, boundsWidth, kWineDetailImageHeight);
    CGRect imageFrame = CGRectMake((boundsWidth - kWineDetailImageWidth) / 2.,
            .0, kWineDetailImageWidth, kWineDetailImageHeight);
    
    [_footerView setFrame:footerFrame];
    [_imageView setFrame:imageFrame];
    [tableView setTableHeaderView:_headerView];
    [tableView setTableFooterView:_footerView];
    [self refresh];
}*/

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[WineDetailDataSource alloc] initWithWineId:_wineId
            delegate:self] autorelease]];
}

#pragma mark -
#pragma mark StoreDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
        imageView = _imageView, footerView = _footerView;

- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
        _wineId = [wineId copy];
        // Conf nav bar
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
        /*[self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                autorelease]];
        [self setFooterView:[[[UIView alloc] initWithFrame:CGRectZero]
                autorelease]];
        [self setImageView:[[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0, kWineDetailImageWidth,
                    kWineDetailImageHeight)] autorelease]];
        [_imageView setDefaultImage:TTIMAGE(kWineDetailDefaultImage)];
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
        [_footerView addSubview:_imageView];*/
    }
    return self;
}

#pragma mark -
#pragma mark <StoreDetailDataSourceDelegate>

- (void)        dataSource:(WineDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title
{
    // First we deal with the title
    UITableView *tableView = [self tableView];
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect headerFrame = [_headerView frame];
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    /*if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];*/
    headerFrame.size.height += titleHeight; 
    [_headerView setFrame:headerFrame];
    [tableView setTableHeaderView:_headerView];
}

- (void) dataSource:(WineDetailDataSource *)dataSource
      viewForHeader:(UIView *)view
{
    UITableView *tableView = [self tableView];
    [tableView setTableHeaderView:view];
}
@end