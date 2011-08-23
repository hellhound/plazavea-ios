#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

extern NSString *kReachabilityChangedNotification;

typedef enum {
    NotReachable = 0,
    ReachableViaWifi,
    ReachableViaWWAN
} NetworkStatus;

@interface Reachability: NSObject
{
    BOOL localWifiRef;
    SCNetworkReachabilityRef reachabilityRef;
}

// atomic property, therefore is thread-safe
@property (assign) BOOL localWifiRef;
// atomic property, therefore is thread-safe
@property (assign) SCNetworkReachabilityRef reachabilityRef;

// reachabilityWithHostName- Use to check the reachability of a particular host
// name. 
+ (Reachability *)reachabilityWithHostName:(NSString*)hostName;
// reachabilityWithAddress- Use to check the reachability of a particular IP
// address. 
+ (Reachability *)reachabilityWithAddress:
    (const struct sockaddr_in*)hostAddress;
// reachabilityForInternetConnection- checks whether the default route is
// available.  
// Should be used by applications that do not connect to a particular host
+ (Reachability *)reachabilityForInternetConnection;
// reachabilityForLocalWifi- checks whether a local Wifi connection is
// available.
+ (Reachability *)reachabilityForLocalWifi;

// Start listening for reachability notifications on the current run loop
- (BOOL)startNotifier;
- (void)stopNotifier;
- (NetworkStatus)currentReachabilityStatus;
// WWAN may be available, but not active until a connection has been established
// Wifi may require a connection for VPN on Demand.
- (BOOL)connectionRequired;
@end


