#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Wines/Constants.h"
#import "Wines/WineDetailController.h"

@interface WineDetailController()

@property (nonatomic, retain) UIView *headerView;
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
    [_titleLabel release];
    [_imageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[WineDetailDataSource alloc] initWithWineId:_wineId]
            autorelease]];
}

#pragma mark -
#pragma mark StoreDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
imageView = _imageView;

- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        _wineId = [wineId copy];
    }
    return self;
}
@end