#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/NonEditableLauncherView.h"

@interface LauncherViewController: TTViewController <TTLauncherViewDelegate>
{
    NonEditableLauncherView *_launcherView;
}
@end
