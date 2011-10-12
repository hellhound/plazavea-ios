#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

@interface RecipeDrillDownController: ReconnectableTableViewController
{
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
}
@property (nonatomic, assign) NSInteger segmentIndex;
@end
