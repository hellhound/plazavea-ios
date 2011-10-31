#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

#import "Stores/Constants.h"
#import "Stores/StoreMapController.h"

@implementation StoreMapController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:kStoreMapTitle];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect viewBounds = [[self view] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:viewBounds];
    [mapView setDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    [[self view] addSubview:mapView];
}
@end