#import <Foundation/Foundation.h>

#import "Common/Networking/Reachability.h"
#import "Common/Controllers/Three20/TableViewController.h"

@interface ReconnectableTableViewController: TableViewController
{
    Reachability *hostReachability;
    BOOL didEnterBackground;
}
@end
