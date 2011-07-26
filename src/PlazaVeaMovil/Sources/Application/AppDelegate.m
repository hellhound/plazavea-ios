#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark -
#pragma mark AppDelegate

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)options
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window makeKeyAndVisible];
    return YES;
}
@end
