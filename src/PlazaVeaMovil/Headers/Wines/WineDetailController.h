#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Wines/WineDetailDataSource.h"

@interface WineDetailController : ReconnectableTableViewController
        <WineDetailDataSourceDelegate>
{
    NSString *_wineId;
    UIView *_headerView;
    UIView *_footerView;
    UILabel *_titleLabel;
    TTImageView *_imageView;
}

- (id)initWithWineId:(NSString *)wineId;
@end