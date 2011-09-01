#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Networking/Reachability.h"
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

@interface ReconnectableTableViewController (Private)

- (void)applicationWillResignActive:(NSNotification *)note;
- (void)applicationDidBecomeActive:(NSNotification *)note;
- (void)reachabilityChanged:(NSNotification *)note;
- (void)resetBackgroundNotification;
- (void)resetApplicationNotification;
- (void)resetReachabilityNotification;
- (void)stopReachabilityNotification;
- (void)stopAllNotifications;
@end

@implementation ReconnectableTableViewController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if (self = [super initWithNibName:nibName bundle:bundle]) {
        hostReachability =
                [[Reachability reachabilityWithHostName:HOST_NAME] retain];
        // subscribe to active state resignation notification
        [self resetBackgroundNotification];
    }
    return self;
}

- (void)dealloc
{
    // This is redundant (it's already addressed in viewDidUnload and
    // viewWillDissapear) either way we do it just in case
    [self stopAllNotifications];
    [hostReachability release];
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // stop all notifications before dismissing the view
    [self stopAllNotifications];
    [super viewWillDisappear:animated];
}

/*
 * FIXME this isn't a solution, we need to find a workaround for this!
- (void)viewDidUnload
{
    // We got a memory warning, stop everything
    [self stopAllNotifications];
    [super viewDidUnload];
}
*/

- (void)willLoadModel
{
    // set up the reachability callback before loading the model
    [self resetApplicationNotification];
    [super willLoadModel];
}

- (void)didLoadModel:(BOOL)firstTime
{
    // We don't need reachability notifications because the model was already
    // loaded, dismiss it
    [self stopReachabilityNotification];
    [super didLoadModel:firstTime];
}

- (void)viewDidLoad
{
    // The view was loaded, see if we need reachability notifications
    if ([self modelError] != nil)
        [self resetReachabilityNotification];
    [super viewDidLoad];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)showError:(BOOL)show
{
    // Set the callback for reachability test
    [self resetReachabilityNotification];
    [super showError:show];
}

#pragma mark -
#pragma mark ReconnectableTableViewController (Private)

- (void)applicationWillResignActive:(NSNotification *)note
{
    didEnterBackground = YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)note
{
    // The application became active, see if we need reachability notifications
    if ([self modelError] != nil)
        [self resetReachabilityNotification];
    // See if the application comes from the background into the foreground
    if (didEnterBackground) {
        didEnterBackground = NO;
        [self reload];
    }
}

- (void)reachabilityChanged:(NSNotification *)note
{
    // Reload the model controller if only there was an error loading the model
    // and we have got host reachability
    if ([self modelError] != nil &&
            [hostReachability currentReachabilityStatus] != NotReachable) {
        [self stopReachabilityNotification];
        [self reload];
    }
}

- (void)resetBackgroundNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
            name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(applicationWillResignActive:)
                name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)resetApplicationNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
            name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(applicationDidBecomeActive:)
            name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)resetReachabilityNotification
{
    [hostReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self
            name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(reachabilityChanged:)
            name:kReachabilityChangedNotification object:nil];
    [hostReachability startNotifier];
}

- (void)stopReachabilityNotification
{
    [hostReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self
            name:kReachabilityChangedNotification object:nil];
}

- (void)stopAllNotifications
{
    [hostReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
