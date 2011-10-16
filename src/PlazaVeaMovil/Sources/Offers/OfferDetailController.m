#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/OfferDetailDataSource.h"
#import "Offers/OfferDetailController.h"

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
#pragma mark UIView

- (void)loadView
{
    [super loadView];

    UITableView *tableView = [self tableView];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0,
            boundsWidth, kOfferDetailImageWidth);
    CGRect imageFrame = CGRectMake((boundsWidth - kOfferDetailImageWidth) / 2.,
            .0, kOfferDetailImageWidth, kOfferDetailImageHeight);

    [_headerView setFrame:headerFrame];
    [_imageView setFrame:imageFrame];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[OfferDetailDataSource alloc]
            initWithOfferId:_offerId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark RecipeController (Private)

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
        // Configuring the label
        [self setTitleLabel:
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [_titleLabel setTextAlignment:UITextAlignmentCenter];
        // Adding the subviews to the header view
        [_headerView addSubview:_titleLabel];
        [_headerView addSubview:_imageView];
    }
    return self;
}

#pragma mark -
#pragma mark <OfferDetailDataSourceDelegate>

- (void)        dataSource:(OfferDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title
{
    // First we deal with the title
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([[self view] bounds]);
    CGFloat titleHeight = [title sizeWithFont:font
        forWidth:titleWidth
        lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    CGRect imageFrame = [_imageView frame];

    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    [_imageView setFrame:CGRectOffset(imageFrame, .0, titleHeight)];
    if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];
}
@end
