#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/UIDevice+Additions.h"
#import "Common/Additions/CLLocation+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Constants.h"
#import "Common/Views/PageCurlButton.h"
#import "Launcher/Constants.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"
#import "Stores/StoreMapController.h"

@interface StoreMapController ()

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) UISegmentedControl *segControl;
@property (nonatomic, assign) MKCoordinateRegion region;
@property (nonatomic, retain) UISegmentedControl *mapTypeControl;
@property (nonatomic, retain) UILabel *mapTypeLabel;

- (void)switchControllers:(UISegmentedControl *)segControl;
- (void)switchMapType:(UISegmentedControl *)segControl;
- (UIButton *)buttonWithImage:(NSString *)imageName action:(SEL)action;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setToolbarHidden:NO animated:YES];
    [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_mapView setShowsUserLocation:NO];
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    //[self setToolbarItems:nil];
    if (_backButton == nil) {
        _backButton = [[UIBarButtonItem alloc] initWithTitle:_buttonTitle
                style:UIBarButtonItemStylePlain target:self
                    action:@selector(popToNavigationWindow)];
        [navItem setLeftBarButtonItem:_backButton];
    }
    // Conf seg
    _segControl = nil;
    UIBarButtonItem *segItem = [[[UIBarButtonItem alloc]
            initWithCustomView:[self segControl]] autorelease];
    // Conf GPS
    UIBarButtonItem *GPSItem = [[[UIBarButtonItem alloc] initWithCustomView:
            [self buttonWithImage:kStoreMapGPSButton
                action:@selector(updateUserAnnotation:)]] autorelease];
    // Conf CurlButton
    PageCurlButton *pageCurlButton = [[[PageCurlButton alloc]
            initWithFrame:CGRectZero] autorelease];
    UIImage *pageCurl = [UIImage imageNamed:@"pagecurl.png"];
    
    [pageCurlButton setImage:pageCurl forState:UIControlStateNormal];
    [pageCurlButton setFrame:CGRectMake(.0, .0, pageCurl.size.width,
            pageCurl.size.height)];
    [pageCurlButton setDelegate:self];
    
    UIBarButtonItem *curlItem = [[[UIBarButtonItem alloc]
            initWithCustomView:pageCurlButton] autorelease];
    // Conf a spacer
    UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];
    
    [self setToolbarItems:[NSArray arrayWithObjects:
            GPSItem, spacerItem, segItem, spacerItem, curlItem, nil]];
    [[self navigationController] setToolbarHidden:NO];
    return navItem;
}

#pragma mark -
#pragma mark TTModelViewController

- (void)didLoadModel:(BOOL)firstTime
{
    CGRect viewBounds = [[self view] bounds];
    NSArray *stores;
        
    [self setMapView:[[MKMapView alloc] initWithFrame:viewBounds]];
    
    [(PageCurlButton *)[[[self toolbarItems] objectAtIndex:4] customView]
            setTargetView:_mapView];
        
    if ([[self model] isKindOfClass:[StoreCollection class]]) {
        stores = [(StoreCollection *)[self model] stores];
        
        for (NSArray *sections in stores) {
            for (Store *store in sections) {
                CLLocationCoordinate2D coordinate;

                coordinate.latitude = [[store latitude] doubleValue];
                coordinate.longitude = [[store longitude] doubleValue];

                MapAnnotation *annotation = [[[MapAnnotation alloc]
                        initWithCoordinate:coordinate] autorelease];
                
                [annotation setTitle:[store name]];
                [annotation setSubtitle:[store storeAddress]];
                [annotation setPictureURL:[[store pictureURL] absoluteString]];
                [annotation setStoreId:[store storeId]];
                [_mapView addAnnotation:annotation];
            }
        }
    } else if ([[self model] isKindOfClass:[Store class]]) {
        Store *store = (Store *)[self model];
        
        CLLocationCoordinate2D coordinate;

        coordinate.latitude = [[store latitude] doubleValue];
        coordinate.longitude = [[store longitude] doubleValue];

        MapAnnotation *annotation = [[[MapAnnotation alloc]
                initWithCoordinate:coordinate] autorelease];
        
        [annotation setTitle:[store name]];
        [annotation setSubtitle:[store storeAddress]];
        [annotation setPictureURL:[[store pictureURL] absoluteString]];
        [_mapView addAnnotation:annotation];
    }
    
    float minLatitude = 0, minLongitude = 0, maxLatitude = 0, maxLongitude = 0;
    
    for (MapAnnotation *annotation in [_mapView annotations]) {
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
    CLLocationCoordinate2D center;

    center.latitude = maxLatitude - (span.latitudeDelta / 2);
    center.longitude = maxLongitude - (span.longitudeDelta / 2);
    
    CLLocationDistance distance = [pointA distanceFrom:pointB];

    [_mapView setDelegate:self];
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    if (distance <= minRegion) {
        [_mapView setRegion:MKCoordinateRegionMakeWithDistance
                (center, minRegion, minRegion)];
    } else {
        [_mapView setRegion:MKCoordinateRegionMake(center, span)];
    }
     _region = [_mapView region];
    [[self view] addSubview:_mapView];
}

#pragma mark -
#pragma mark StoreMapController

@synthesize mapView = _mapView, region = _region, buttonTitle = _buttonTitle;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
                 andTitle:(NSString *)title
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setButtonTitle:title];
        [self setTitle:kStoreMapTitle];
        [self setModel:[[[StoreCollection alloc] initWithSubregionId:subregionId
                andRegionId:regionId] autorelease]];
    }
    return self;
}

- (id)initWithStoreId:(NSString *)storeId
             andTitle:(NSString *)title
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setButtonTitle:title];
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
         popViewControllerAnimated:NO];
    } else {
        [(UINavigationController *)
         [[self parentViewController] parentViewController]
         popViewControllerAnimated:NO];
    }
}

#pragma mark -
#pragma mark StoreMapController (Private)

@synthesize segControl = _segControl, mapTypeControl = _mapTypeControl,
        mapTypeLabel = _mapTypeLabel;

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

- (UIButton *)buttonWithImage:(NSString *)imageName action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake
            (.0, .0, image.size.width, image.size.height)] autorelease];
    
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
    return button;
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

- (void)switchMapType:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kMapStyleSegmentedControlIndexStandard:
            [_mapView setMapType:MKMapTypeStandard];
            break;
        case kMapStyleSegmentedControlIndexSatellite:
            [_mapView setMapType:MKMapTypeSatellite];
            break;
        case kMapStyleSegmentedControlIndexHybrid:
            [_mapView setMapType:MKMapTypeHybrid];
            break;
        default:
            [_mapView setMapType:MKMapTypeStandard];
            break;
    }
    [(PageCurlButton *)[[[self toolbarItems] objectAtIndex:4] customView]
            curlViewDown];
}

- (void)updateUserAnnotation:(id)sender
{
    [_mapView setShowsUserLocation:YES];
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
    MKCoordinateSpan span = _region.span;
    CLLocationCoordinate2D currentLocation =
            [[userLocation location] coordinate];
    
    for (MapAnnotation *annotation in [_mapView annotations]) {
        if ([[annotation title] isEqualToString:kStoreMapCurrentLocation])
            [_mapView removeAnnotation:annotation];
    }
    MapAnnotation *location = [[[MapAnnotation alloc]
            initWithCoordinate:currentLocation] autorelease];
    
    [location setTitle:kStoreMapCurrentLocation];
    [_mapView addAnnotation:location];
    
    float minLatitude = MIN((center.latitude - (span.latitudeDelta / 2)),
            currentLocation.latitude);
    float minLongitude = MIN((center.longitude - (span.longitudeDelta / 2)),
            currentLocation.longitude);
    float maxLatitude = MAX((center.latitude + (span.latitudeDelta / 2)),
            currentLocation.latitude);
    float maxLongitude = MAX((center.longitude + (span.longitudeDelta / 2)),
            currentLocation.longitude);
    
    MKCoordinateSpan newSpan =
            MKCoordinateSpanMake((maxLatitude - minLatitude),
                (maxLongitude - minLongitude));
    CLLocationCoordinate2D newCenter;

    newCenter.latitude = maxLatitude - (newSpan.latitudeDelta / 2);
    newCenter.longitude = maxLongitude - (newSpan.longitudeDelta / 2);
    
    [[self mapView] setRegion:MKCoordinateRegionMake(newCenter, newSpan)
            animated:YES];
    if ([[userLocation location] horizontalAccuracy] <= 100.)
        [_mapView setShowsUserLocation:NO];
    [_mapView performSelector:@selector(setShowsUserLocation:) withObject:NO
            afterDelay:10];
}

- (void)                mapView:(MKMapView *)mapView
   didFailToLocateUserWithError:(NSError *)error
{
    [_mapView setShowsUserLocation:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([[annotation title] isEqualToString:kStoreMapCurrentLocation]) {
        MKPinAnnotationView *pin = (MKPinAnnotationView *)[_mapView
                dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationId];
        
        if (pin == nil) {
            pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                    reuseIdentifier:kPinAnnotationId] autorelease];
        }
        [pin setPinColor:MKPinAnnotationColorGreen];
        [pin setCanShowCallout:YES];
        [pin setAnimatesDrop:YES];
        return pin;
    }
    MKAnnotationView *annotationView = (MKAnnotationView *)[_mapView
            dequeueReusableAnnotationViewWithIdentifier:kAnnotationId];
    if (annotationView == nil) {
        annotationView = [[[MKAnnotationView alloc]
                initWithAnnotation:annotation reuseIdentifier:kAnnotationId]
                    autorelease];
    }
    [annotationView setImage:[UIImage imageNamed:kStoreMapAnnotationImage]];
    [annotationView setCanShowCallout:YES];
    if ([(MapAnnotation *)annotation storeId] != nil) {
        [annotationView setRightCalloutAccessoryView:
                [UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    }
    /*TTImageView *image = [[[TTImageView alloc] initWithFrame:
            CGRectMake(.0, .0, kStoreMapImageWidth, kStoreMapImageHeight)]
                autorelease];
    
    [image setUrlPath:[(MapAnnotation *)annotation pictureURL]];
    [image performSelector:@selector(stopLoading) withObject:nil
            afterDelay:10];
    [annotationView setLeftCalloutAccessoryView:image];*/
    //[annotationView setAnimatesDrop:YES];
    return annotationView;
}

- (void)                mapView:(MKMapView *)mapView
                 annotationView:(MKAnnotationView *)view
  calloutAccessoryControlTapped:(UIControl *)control
{
    NSNumber *storeId = [(MapAnnotation *)[view annotation] storeId];
    [[TTNavigator navigator] openURLAction:
     [[TTURLAction actionWithURLPath:URL(kURLStoreDetailCall, storeId)]
        applyAnimated:YES]];
}

#pragma mark -
#pragma mark <PageCurlButtonDelegate>

- (void)pageCurlButtonWillCurlViewUp:(PageCurlButton *)control
{
    [[self view] setBackgroundColor:[UIColor lightGrayColor]];
    if (_mapTypeLabel == nil) {
        _mapTypeLabel = [[[UILabel alloc] init] autorelease];
        
        [_mapTypeLabel setFrame:CGRectMake(20., 260., 280., 40.)];
        [_mapTypeLabel setFont:[UIFont boldSystemFontOfSize:14.]];
        [_mapTypeLabel setText:kStoreMapTypeLabel];
        [_mapTypeLabel setTextColor:[UIColor darkGrayColor]];
        [_mapTypeLabel setShadowColor:[UIColor whiteColor]];
        [_mapTypeLabel setShadowOffset:CGSizeMake(.0, 1.)];
        [_mapTypeLabel setBackgroundColor:[UIColor clearColor]];
        [_mapTypeLabel setTextAlignment:UITextAlignmentCenter];
        [[self view] insertSubview:_mapTypeLabel atIndex:0];
    }
    if (_mapTypeControl == nil) {
        _mapTypeControl = [[[UISegmentedControl alloc] initWithItems:
                [NSArray arrayWithObjects:kStoreMapTypeStandard,
                    kStoreMapTypeSatellite, kStoreMapTypeHybrid, nil]]
                    autorelease];
        
        switch ([_mapView mapType]) {
            case MKMapTypeStandard:
                [_mapTypeControl setSelectedSegmentIndex:0];
                break;
            case MKMapTypeSatellite:
                [_mapTypeControl setSelectedSegmentIndex:1];
                break;
            case MKMapTypeHybrid:
                [_mapTypeControl setSelectedSegmentIndex:2];
                break;
            default:
                [_mapTypeControl setSelectedSegmentIndex:0];
                break;
        }
        [_mapTypeControl setFrame:CGRectMake(20., 300., 280., 50.)];
        [_mapTypeControl addTarget:self action:@selector(switchMapType:)
                forControlEvents:UIControlEventValueChanged];
        [[self view] insertSubview:_mapTypeControl atIndex:0];
    }
}

- (void)pageCurlButtonDidCurlViewDown:(PageCurlButton *)control
{
    [_mapTypeControl removeFromSuperview];
    [_mapTypeLabel removeFromSuperview];
    
    _mapTypeControl = nil;
    _mapTypeLabel = nil;
}
@end