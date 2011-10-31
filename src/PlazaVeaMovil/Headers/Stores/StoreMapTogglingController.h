#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Stores/StoreListDataSource.h"

@interface StoreMapTogglingController: ReconnectableTableViewController
        <StoreListDataSourceDelegate>
{
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
    NSArray *_stores;
}
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, retain) NSArray *stores;
@end