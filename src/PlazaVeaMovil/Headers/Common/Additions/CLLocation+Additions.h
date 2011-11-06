#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Additions)

- (CLLocationDistance)distanceFrom:(const CLLocation *)location;
@end
