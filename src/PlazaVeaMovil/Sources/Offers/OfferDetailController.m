#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/OfferDetailDataSource.h"
#import "Offers/OfferDetailController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface OfferDetailController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TTImageView *imageView;
@end

@implementation OfferDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_offerId release];
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
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0,
            boundsWidth, kOfferDetailImageWidth);
    CGRect imageFrame = CGRectMake((boundsWidth - kOfferDetailImageWidth) / 2.,
            .0, kOfferDetailImageWidth, kOfferDetailImageHeight);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [tableView setTableHeaderView:_headerView];
    [self refresh];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[OfferDetailDataSource alloc]
            initWithOfferId:_offerId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark OfferDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
imageView = _imageView;

#pragma mark -
#pragma mark OfferDetailController (Public)

- (id)initWithOfferId:(NSString *)offerId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:NSLocalizedString(kOfferDetailTitle, nil)];
        _offerId = [offerId copy];
        // Configuring the header view
        [self setHeaderView:
         [[[UIView alloc] initWithFrame:CGRectZero] autorelease]];
        // Configuring the image view
        [self setImageView:[[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0,
                    kOfferDetailImageWidth,
                    kOfferDetailImageHeight)] autorelease]];
        [_imageView setDefaultImage:TTIMAGE(kOfferDetailDefaultImage)];
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
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
            [_titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
        }
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(headerColorYellow)]) {
            [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
        }
        // Adding the subviews to the header view
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(offerBackgroundHeader)]) {
            UIImageView *back = [[[UIImageView alloc] initWithImage:
                    (UIImage *)TTSTYLE(offerBackgroundHeader)] autorelease];
            
            [_headerView insertSubview:back atIndex:0];
        }
        [_headerView addSubview:_titleLabel];
        [_headerView addSubview:_imageView];
        [_headerView setClipsToBounds:YES];
    }
    return self;
}

#pragma mark -
#pragma mark <OfferDetailDataSourceDelegate>

- (void)        dataSource:(OfferDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title
{
    if (imageURL != nil){
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
        
        if ((titleHeight + (margin * 2)) <= headerMinHeight) {
            titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
            titleHeight = headerMinHeight - (margin * 2);
        } else {
            titleFrame.origin.y += margin;
        }
        CGRect imageFrame = [_imageView frame];
        
        [_titleLabel setText:title];
        [_titleLabel setFrame:titleFrame];
        [_imageView setFrame:
                CGRectOffset(imageFrame, .0, titleHeight + (margin * 2))];
        if (imageURL != nil)
            [_imageView setUrlPath:[imageURL absoluteString]];
        headerFrame.size.height += titleHeight + (margin * 2);
        
        UIView *whiteBackground =
                [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        
        [whiteBackground setBackgroundColor:[UIColor whiteColor]];
        
        CGRect frame = _imageView.frame;
        frame.origin.x = 0.;
        frame.size.width = 320.;
        
        [whiteBackground setFrame:frame];
        [_headerView insertSubview:whiteBackground atIndex:1];
        [_headerView setFrame:headerFrame];
        [tableView setTableHeaderView:_headerView];
    }
}
@end