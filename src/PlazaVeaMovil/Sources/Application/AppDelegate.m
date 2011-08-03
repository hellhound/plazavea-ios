#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/ShoppingListController.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_window release];
    [_context release];
    [_model release];
    [_coordinator release];
    [_dateFormatter release];
    [super dealloc];
}

#pragma mark -
#pragma mark <UIApplicationDelegate>

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)options
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // TODO The root view controller should be the one of the launcher
    ShoppingListController *shoppingController =
            [[[ShoppingListController alloc]
                initWithNibName:nil bundle:nil] autorelease];
    UINavigationController *navController =
            [[[UINavigationController alloc]
                initWithRootViewController:shoppingController] autorelease];

    [_window setRootViewController:navController];
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
