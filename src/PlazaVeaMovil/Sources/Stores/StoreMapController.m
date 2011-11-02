#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/UIDevice+Additions.h"
#import "Launcher/Constants.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"
#import "Stores/StoreMapController.h"

// min region
static float minRegion = 500.;

@interface StoreMapController ()

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) UISegmentedControl *segControl;
@property (nonatomic, assign) MKCoordinateRegion region;

- (void)switchControllers:(UISegmentedControl *)segControl;
@end

@implementation StoreMapController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_mapView release];
    [_segControl release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:kStoreMapTitle];
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[self mapView] setShowsUserLocation:NO];
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    if ([self toolbarItems] == nil) {
        // Conf the segmented item
        UIBarButtonItem *segItem = [[[UIBarButtonItem alloc]
                initWithCustomView:[self segControl]] autorelease];
        // Conf GPS
        UIBarButtonItem *GPSItem = [[[UIBarButtonItem alloc]
                initWithTitle:kStoreMapGPSButton
                    style:UIBarButtonItemStyleBordered target:self
                    action:@selector(toggleUserAnnotation:)]
                    autorelease];
        // Conf CurlButton
        UIBarButtonItem *curlItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl
                    target:self action:NULL] autorelease];
        // Conf a spacer
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                    target:nil action:NULL] autorelease];
        
        [self setToolbarItems:[NSArray arrayWithObjects:
                GPSItem, spacerItem, segItem, spacerItem, curlItem, nil]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

#pragma mark -
#pragma mark TTModelViewController

- (void)didLoadModel:(BOOL)firstTime
{
    CGRect viewBounds = [[self view] bounds];
    NSArray *stores;
    
    [self setMapView:[[MKMapView alloc] initWithFrame:viewBounds]];
        
    if ([[self model] isKindOfClass:[StoreCollection class]]) {
        stores = [(StoreCollection *)[self model] stores];
        
        for (NSArray *sections in stores) {
            for (Store *store in sections) {
                CLLocationCoordinate2D coordinate =
                CLLocationCoordinate2DMake([[store latitude] doubleValue],
                        [[store longitude] doubleValue]);
                MapAnnotation *annotation = [[[MapAnnotation alloc]
                        initWithCoordinate:coordinate title:[store name]
                            andSubtitle:nil] autorelease];
                [[self mapView] addAnnotation:annotation];
            }
        }
    } else if ([[self model] isKindOfClass:[Store class]]) {
        Store *store = (Store *)[self model];
        
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([[store latitude] doubleValue],
                [[store longitude] doubleValue]);
        MapAnnotation *annotation = [[[MapAnnotation alloc]
                initWithCoordinate:coordinate title:[store name]
                    andSubtitle:[store storeAddress]] autorelease];
        [[self mapView] addAnnotation:annotation];
    }
    
    float minLatitude = 0, minLongitude = 0, maxLatitude = 0, maxLongitude = 0;
    
    for (MapAnnotation *annotation in [[self mapView] annotations]) {
        minLatitude = minLatitude == 0 ? [annotation coordinate].latitude :
                MIN(minLatitude, [annotation coordinate].latitude);
        minLongitude = minLongitude == 0 ? [annotation coordinate].longitude :
                MIN(minLongitude, [annotation coordinate].longitude);
        maxLatitude = maxLatitude == 0 ? [annotation coordinate].latitude :
                MAX(maxLatitude, [annotation coordinate].latitude);
        maxLongitude = maxLongitude == 0 ? [annotation coordinate].longitude :
                MAX(maxLongitude, [annotation coordinate].longitude);
    }
    CLLocation *pointA = [[[CLLocation alloc] initWithLatitude:minLatitude
            longitude:minLongitude] autorelease];
    CLLocation *pointB = [[[CLLocation alloc] initWithLatitude:maxLatitude
            longitude:minLongitude] autorelease];
    MKCoordinateSpan span =
            MKCoordinateSpanMake((maxLatitude - minLatitude),
                (maxLongitude - minLongitude));
    CLLocationCoordinate2D center =
            CLLocationCoordinate2DMake((maxLatitude - (span.latitudeDelta / 2)),
                (maxLongitude - (span.longitudeDelta / 2)));
    
    float distance = [pointA distanceFromLocation:pointB];
    [[self mapView] setDelegate:self];
    [[self mapView] setMapType:MKMapTypeStandard];
    [[self mapView] setZoomEnabled:YES];
    [[self mapView] setScrollEnabled:YES];
    if (distance <= minRegion) {
        [[self mapView] setRegion:MKCoordinateRegionMakeWithDistance
                (center, minRegion, minRegion)];
    } else {
        [[self mapView] setRegion:MKCoordinateRegionMake(center, span)];
    }
     _region = [[self mapView] region];
    [[self view] addSubview:[self mapView]];
}

#pragma mark -
#pragma mark StoreMapController

@synthesize mapView = _mapView, region = _region;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTitle:kStoreMapTitle];
        [self setModel:[[[StoreCollection alloc] initWithSubregionId:subregionId
                andRegionId:regionId] autorelease]];
    }
    return self;
}

- (id)initWithStoreId:(NSString *)storeId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTitle:kStoreMapTitle];
        [self setModel:[[[Store alloc] initWithStoreId:storeId] autorelease]];
    }
    return self;
}

- (void)popToNavigationWindow
{
    [self dismissModalViewControllerAnimated:YES];
    if ([[UIDevice currentDevice] deviceSystemVersion] > kSystemVersion4) {
        [(UINavigationController *)
         [[self parentViewController] performSelector:
          @selector(presentingViewController)]
         popToRootViewControllerAnimated:NO];
    } else {
        [(UINavigationController *)
         [[self parentViewController] parentViewController]
         popToRootViewControllerAnimated:NO];
    }
}

#pragma mark -
#pragma mark StoreMapController (Private)

@synthesize segControl = _segControl;

- (UISegmentedControl *)segControl
{
    if (_segControl != nil)
        return _segControl;
    // Conf the segmented control
    [_segControl autorelease];
    _segControl = [[UISegmentedControl alloc] initWithItems:
                   [NSArray arrayWithObjects:kStoreListButtonLabel,
                    kStoreMapButtonLabel, nil]];
    [_segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segControl setSelectedSegmentIndex:kStoreSegmentedControlIndexMapButon];
    [_segControl addTarget:self action:@selector(switchControllers:)
          forControlEvents:UIControlEventValueChanged];
    return _segControl;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [[TTNavigator navigator] openURLAction:
             [[TTURLAction actionWithURLPath:kURLStoreMap] applyAnimated:YES]];
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}

- (void)toggleUserAnnotation:(id)sender
{
    [_mapView setShowsUserLocation:![_mapView showsUserLocation]];
}

#pragma mark -
#pragma mark StoreMapController (Public)

@synthesize segmentIndex = _segmentIndex;

- (void)setSegmentIndex:(NSInteger)segmentedIndex
{
    UISegmentedControl *segControl = [self segControl];
    
    [segControl removeTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
    [segControl setSelectedSegmentIndex:segmentedIndex];
    [segControl addTarget:self action:@selector(switchControllers:)
         forControlEvents:UIControlEventValueChanged];
}


#pragma mark -
#pragma mark <MKMapViewDelegate>

- (void)        mapView:(MKMapView *)mapView
  didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D center = _region.center;
    CLLocationCoordinate2D currentLocation =
            [[userLocation location] coordinate];
    
    float minLatitude = MIN(center.latitude, currentLocation.latitude);
    float minLongitude = MIN(center.longitude, currentLocation.longitude);
    float maxLatitude = MAX(center.latitude, currentLocation.latitude);
    float maxLongitude = MAX(center.longitude, currentLocation.longitude);
    
    MKCoordinateSpan span =
            MKCoordinateSpanMake((maxLatitude - minLatitude),
                (maxLongitude - minLongitude));
    CLLocationCoordinate2D newCenter =
            CLLocationCoordinate2DMake((maxLatitude - (span.latitudeDelta / 2)),
                (maxLongitude - (span.longitudeDelta / 2)));
    
    [[self mapView] setRegion:MKCoordinateRegionMake(newCenter, span)
            animated:YES];
}
@end