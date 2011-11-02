#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Stores/StoreListDataSource.h"

@protocol StoreMapTogglingControllerDelegate;

@interface StoreMapTogglingController: ReconnectableTableViewController
        <StoreListDataSourceDelegate>
{
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
    NSArray *_stores;
    id<StoreMapTogglingControllerDelegate> _delegate;
}
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, retain) NSArray *stores;
@property (nonatomic, assign) id delegate;
@end

@protocol StoreMapTogglingControllerDelegate <NSObject>
- (void) controller:(StoreMapTogglingController *)controller
        needsStores:(NSArray *)stores;
@end