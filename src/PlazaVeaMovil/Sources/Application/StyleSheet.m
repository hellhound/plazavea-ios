#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Application/Constants.h"
#import "Application/StyleSheet.h"

//launcher
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://launcher-background.png")

@implementation StyleSheet

#pragma mark -
#pragma mark Launcher

+ (UIImageView *)launcherBackgroundImage
{
    return [[UIImageView alloc] initWithImage:NAVIGATION_BAR_LOGO];
}
@end
