#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Networking/Reachability.h"

@interface ReconnectableTableViewController: TTTableViewController
{
    Reachability *hostReachability;
    BOOL didEnterBackground;
}
@end
