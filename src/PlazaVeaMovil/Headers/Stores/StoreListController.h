#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Stores/StoreListDataSource.h"
#import "Stores/StoreMapTogglingController.h"

@interface StoreListController : StoreMapTogglingController
        <StoreListDataSourceDelegate>
{
    NSString *_subregionId;
    NSString *_regionId;
    NSArray *_stores;
}
@property (nonatomic, copy) NSString *subregionId;
@property (nonatomic, copy) NSString *regionId;
@property (nonatomic, retain) NSArray *stores;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId;
@end
