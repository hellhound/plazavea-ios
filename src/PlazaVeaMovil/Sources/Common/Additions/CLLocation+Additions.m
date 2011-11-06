#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Common/Additions/UIDevice+Additions.h"
#import "Common/Additions/CLLocation+Additions.h"

@implementation CLLocation (Additions)

#pragma mark -
#pragma mark CLLocation (Additions)

- (CLLocationDistance)distanceFrom:(const CLLocation *)location
{
    CLLocationDistance distance;
    UIDeviceSystemVersion deviceSystemVersion =
            [[UIDevice currentDevice] deviceSystemVersion];
    NSInvocation *invocation;
   
    if (deviceSystemVersion != kSystemVersion32
            && deviceSystemVersion < kSystemVersion4) {
        // Use deprecated method getDistanceFrom:
        invocation = [NSInvocation invocationWithMethodSignature:
                [self methodSignatureForSelector:
                    @selector(getDistanceFrom:)]];
        [invocation setSelector:@selector(getDistanceFrom:)];
    } else {
        // Use distanceFromLocation:, available since iOS 3.2
        invocation = [NSInvocation invocationWithMethodSignature:
                [self methodSignatureForSelector:
                    @selector(distanceFromLocation:)]];
        [invocation setSelector:@selector(distanceFromLocation:)];
    }
    [invocation setTarget:self];
    [invocation setArgument:&location atIndex:2];
    [invocation invoke];
    [invocation getReturnValue:&distance];
    return distance;
}
@end
