#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/ShoppingListsController.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_window release];
    [_rootViewController release];
    [_context release];
    [_model release];
    [_coordinator release];
    [_dateFormatter release];
    [super dealloc];
}

#pragma mark -
#pragma mark AppDelegate (Public)

@synthesize rootViewController = _rootViewController;

#pragma mark -
#pragma mark <UIApplicationDelegate>

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)options
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // TODO The root view controller should be the one of the launcher
    ShoppingListsController *shoppingController =
            [[[ShoppingListsController alloc] init] autorelease];
    _rootViewController = [[UINavigationController alloc]
            initWithRootViewController:shoppingController];

    [_window addSubview:[_rootViewController view]];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the
    // application terminates.
    [self saveContext];
}
@end
