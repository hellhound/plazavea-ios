#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

#import "Common/Views/PageCurlButton.h"

@interface StoreMapController: TTModelViewController
        <MKMapViewDelegate, PageCurlButtonDelegate>
{
    UIBarButtonItem *_backButton;
    NSInteger _segmentIndex;
    UISegmentedControl *_segControl;
    MKMapView *_mapView;
    MKCoordinateRegion _region;
    NSString *_buttonTitle;
    UISegmentedControl *_mapTypeControl;
    UILabel *_mapTypeLabel;
}
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, copy) NSString *buttonTitle;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
                 andTitle:(NSString *)title;
- (id)initWithStoreId:(NSString *)storeId
             andTitle:(NSString *)title;
- (void)popToNavigationWindow;
- (void)updateUserAnnotation:(id)sender;
@end