#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface LauncherViewController: UIViewController <TTLauncherViewDelegate>
{
    TTLauncherView *_launcherView;
}
@end
