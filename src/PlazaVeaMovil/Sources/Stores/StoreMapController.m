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

@interface StoreMapController ()

@property (nonatomic, readonly) UISegmentedControl *segControl;

- (void)switchControllers:(UISegmentedControl *)segControl;
@end

@implementation StoreMapController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
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

/*- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect viewBounds = [[self view] bounds];
    UINavigationController *navigationController = [self navigationController];
    
    if (![navigationController isToolbarHidden]) {
        viewBounds.size.height -=
                CGRectGetHeight([[navigationController toolbar] frame]);
    }
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:viewBounds];

    [mapView setDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    [[self view] addSubview:mapView];
}*/

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
                    style:UIBarButtonItemStyleBordered target:self action:NULL]
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
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:viewBounds];
    NSArray *stores = [(StoreCollection *)[self model] stores];
    
    for (NSArray *sections in stores) {
        for (Store *store in sections) {
            CLLocationCoordinate2D coordinate =
                    CLLocationCoordinate2DMake([[store latitude] doubleValue],
                        [[store longitude] doubleValue]);
            MapAnnotation *annotation = [[[MapAnnotation alloc]
                    initWithCoordinate:coordinate title:[store name]
                        andSubtitle:nil] autorelease];
            [mapView addAnnotation:annotation];
        }
    }
    
    float minLatitude = 0, minLongitude = 0, maxLatitude = 0, maxLongitude = 0;
    
    for (MapAnnotation *annotation in [mapView annotations]) {
        minLatitude = minLatitude == 0 ? [annotation coordinate].latitude :
                MIN(minLatitude, [annotation coordinate].latitude);
        minLongitude = minLongitude == 0 ? [annotation coordinate].longitude :
                MIN(minLongitude, [annotation coordinate].longitude);
        maxLatitude = maxLatitude == 0 ? [annotation coordinate].latitude :
                MAX(maxLatitude, [annotation coordinate].latitude);
        maxLongitude = maxLongitude == 0 ? [annotation coordinate].longitude :
                MAX(maxLongitude, [annotation coordinate].longitude);
    }
    MKCoordinateSpan span =
            MKCoordinateSpanMake((maxLatitude - minLatitude),
                (maxLongitude - minLongitude));
    CLLocationCoordinate2D center =
            CLLocationCoordinate2DMake((maxLatitude - (span.latitudeDelta / 2)),
                (maxLongitude - (span.longitudeDelta / 2)));
    
    [mapView setDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    [mapView setRegion:MKCoordinateRegionMake(center, span)];
    [[self view] addSubview:mapView];
}

#pragma mark -
#pragma mark StoreMapController

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
@end