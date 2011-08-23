#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import "Common/Networking/Reachability.h"

#define SHOULD_PRINT_REACHABILITY_FLAGS 0

static void PrintReachabilityFlags(SCNetworkReachabilityFlags
        flags, const char* comment);
static void ReachabilityCallback(SCNetworkReachabilityRef target,
        SCNetworkReachabilityFlags flags, void* info);

static void PrintReachabilityFlags(SCNetworkReachabilityFlags
        flags, const char* comment)
{
#if SHOULD_PRINT_REACHABILITY_FLAGS
    
    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
        (flags & kSCNetworkReachabilityFlagsIsWWAN) ?
            'W' : '-',
        (flags & kSCNetworkReachabilityFlagsReachable) ?
            'R' : '-',
        (flags & kSCNetworkReachabilityFlagsTransientConnection) ?
            't' : '-',
        (flags & kSCNetworkReachabilityFlagsConnectionRequired) ?
            'c' : '-',
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) ?
            'C' : '-',
        (flags & kSCNetworkReachabilityFlagsInterventionRequired) ?
            'i' : '-',
        (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) ?
            'D' : '-',
        (flags & kSCNetworkReachabilityFlagsIsLocalAddress) ?
            'l' : '-',
        (flags & kSCNetworkReachabilityFlagsIsDirect) ?
            'd' : '-',
        comment
        );
#endif
}

NSString *kReachabilityChangedNotification =
        @"kReachabilityChangedNotification";

@implementation Reachability

#pragma mark -
#pragma mark Reachability

@synthesize localWifiRef, reachabilityRef;

+ (Reachability *)reachabilityWithHostName:(NSString*)hostName;
{
    Reachability *retVal = nil;
    SCNetworkReachabilityRef reachability =
            SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);

    if(reachability != NULL)
        if(retVal = [[[self alloc] init] autorelease]) {
            [retVal setReachabilityRef:reachability];
            [retVal setLocalWifiRef:NO];
        }
    return retVal;
}

+ (Reachability *)reachabilityWithAddress:
        (const struct sockaddr_in*)hostAddress;
{
    SCNetworkReachabilityRef reachability =
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault,
                (const struct sockaddr*)hostAddress);
    Reachability *retVal = nil;

    if(reachability != NULL)
        if(retVal = [[[self alloc] init] autorelease]) {
            [retVal setReachabilityRef:reachability];
            [retVal setLocalWifiRef:NO];
        }
    return retVal;
}

+ (Reachability *)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;

    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:&zeroAddress];
}

+ (Reachability*)reachabilityForLocalWifi
{
    struct sockaddr_in localWifiAddress;

    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);

    Reachability *retVal = [self reachabilityWithAddress:&localWifiAddress];

    if(retVal != nil)
        [retVal setLocalWifiRef:YES];
    return retVal;
}

- (void)dealloc
{
    [self stopNotifier];
    if(reachabilityRef != NULL)
        CFRelease(reachabilityRef);
    [super dealloc];
}

static void ReachabilityCallback(SCNetworkReachabilityRef target,
        SCNetworkReachabilityFlags flags, void* info)
{
    #pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(NSObject *)info isKindOfClass: [Reachability class]],
            @"info was wrong class in ReachabilityCallback");

    // We're on the main RunLoop, so an NSAutoreleasePool is not necessary,
    // but is added defensively in case someon uses the Reachablity object in a
    // different thread.
    NSAutoreleasePool *callbackPool = [[NSAutoreleasePool alloc] init];
    Reachability *noteObject = (Reachability *)info;

    // Post a notification to notify the client that the network reachability
    // changed.
    [[NSNotificationCenter defaultCenter] postNotificationName:
            kReachabilityChangedNotification object:noteObject];
    //[callbackPool drain];
    [callbackPool release];
}

- (BOOL)startNotifier
{
    BOOL retVal = NO;
    SCNetworkReachabilityContext context = {0, self, NULL, NULL, NULL};

    if(SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback,
            &context))
        if(SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef,
                CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
            retVal = YES;
    return retVal;
}

- (void)stopNotifier
{
    if(reachabilityRef != NULL)
        SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef,
                CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
}

#pragma mark -
#pragma mark Network Flag Handling

- (NetworkStatus)localWifiStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "localWifiStatusForFlags");

    BOOL retVal = NotReachable;

    if((flags & kSCNetworkReachabilityFlagsReachable) &&
            (flags & kSCNetworkReachabilityFlagsIsDirect))
        retVal = ReachableViaWifi;    
    return retVal;
}

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
        // if target host is not reachable
        return NotReachable;

    BOOL retVal = NotReachable;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        retVal = ReachableViaWifi;
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
            (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs

        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
            // ... and no [user] intervention is needed
            retVal = ReachableViaWifi;
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) ==
            kSCNetworkReachabilityFlagsIsWWAN)
        // ... but WWAN connections are OK if the calling application
        // is using the CFNetwork (CFSocketStream?) APIs.
        retVal = ReachableViaWWAN;
    return retVal;
}

- (BOOL)connectionRequired;
{
    NSAssert(reachabilityRef != NULL,
            @"connectionRequired called with NULL reachabilityRef");

    SCNetworkReachabilityFlags flags;

    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    return NO;
}

- (NetworkStatus)currentReachabilityStatus
{
    NSAssert(reachabilityRef != NULL,
            @"currentNetworkStatus called with NULL reachabilityRef");

    NetworkStatus retVal = NotReachable;
    SCNetworkReachabilityFlags flags;

    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
        if(localWifiRef) {
            retVal = [self localWifiStatusForFlags:flags];
        } else {
            retVal = [self networkStatusForFlags:flags];
        }
    return retVal;
}
@end
