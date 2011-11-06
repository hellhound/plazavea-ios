
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

@interface StoreMapController: TTModelViewController <MKMapViewDelegate>
{
    UIBarButtonItem *_backButton;
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
    MKMapView *_mapView;
    MKCoordinateRegion _region;
}
@property (nonatomic, assign) NSInteger segmentIndex;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId;
- (id)initWithStoreId:(NSString *)storeId;
- (void)popToNavigationWindow;
- (void)updateUserAnnotation:(id)sender;
@end