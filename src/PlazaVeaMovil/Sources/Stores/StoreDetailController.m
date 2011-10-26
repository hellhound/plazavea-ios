#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Stores/StoreDetailController.h"

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
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StoreDetailDataSource alloc]
            initWithStoreId:_storeId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark OfferDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
    imageView = _imageView;

- (id)initWithStoreId:(NSString *)storeId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        _storeId = [storeId copy];
    }
    return self;
}
@end
