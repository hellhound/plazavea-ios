#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Stores/StoreDetailDataSource.h"
#import "Stores/StoreMapTogglingController.h"

@interface StoreDetailController : StoreMapTogglingController
        <StoreDetailDataSourceDelegate>
{
    NSString *_storeId;
    TTImageView *_imageView;
    UIView *_headerView;
    UILabel *_titleLabel;
    UILabel *_storeLabel;
}

- (id)initWithStoreId:(NSString *)storeId;
@end

