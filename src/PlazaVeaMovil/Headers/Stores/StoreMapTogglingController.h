#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Stores/StoreListDataSource.h"

@interface StoreMapTogglingController: ReconnectableTableViewController
{
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
}
@property (nonatomic, assign) NSInteger segmentIndex;
@end
