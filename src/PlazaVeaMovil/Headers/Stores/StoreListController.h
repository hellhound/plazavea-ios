#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Stores/StoreListDataSource.h"
#import "Stores/StoreMapTogglingController.h"

@interface StoreListController : StoreMapTogglingController
{
    NSString *_subregionId;
    NSString *_regionId;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, copy) NSString *subregionId;
@property (nonatomic, copy) NSString *regionId;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId;
@end
