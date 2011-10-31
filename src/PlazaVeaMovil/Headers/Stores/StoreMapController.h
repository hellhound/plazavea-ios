
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

@interface StoreMapController: TTViewController <MKMapViewDelegate>
{
    UIBarButtonItem *_backButton;
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
}
@property (nonatomic, assign) NSInteger segmentIndex;

- (void)popToNavigationWindow;
@end