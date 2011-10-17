#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/PromotionDetailDataSource.h"
#import "Offers/PromotionDetailController.h"

@interface PromotionDetailController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation PromotionDetailController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_promotionId release];
    [_headerView release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[PromotionDetailDataSource alloc]
            initWithPromotionId:_promotionId delegate:self] autorelease]];
}

#pragma mark -
#pragma PromotionDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel;

#pragma mark -
#pragma mark PromotionDetailController (Public)

- (id)initWithPromotionId:(NSString *)promotionId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:NSLocalizedString(kPromotionDetailTitle, nil)];
        _promotionId = [promotionId copy];
        // Configuring the headerView
        [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                autorelease]];
        // Configuring the title label
        [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
                autorelease]];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [_titleLabel setTextAlignment:UITextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        // Adding the title label to the header
        [_headerView addSubview:_titleLabel];
    }
    return self;
}

#pragma mark -
#pragma mark <PromotionDetailDataSourceDelegate>
- (void)        dataSource:(PromotionDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title
{
    UITableView *tableView = [self tableView];
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGFloat titleHeight = [title sizeWithFont:font forWidth:titleWidth
            lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect headerFrame = [_headerView frame];
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    headerFrame.size.height = titleHeight;
    [_headerView setFrame:headerFrame];
    [tableView setTableHeaderView:_headerView];
}
@end
