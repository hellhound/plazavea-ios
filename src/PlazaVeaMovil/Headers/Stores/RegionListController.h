#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

@interface RegionListController: ReconnectableTableViewController
{
    NSString *_regionId;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, copy) NSString *regionId;

- (id)initWithRegionId:(NSString *)regionId;
@end