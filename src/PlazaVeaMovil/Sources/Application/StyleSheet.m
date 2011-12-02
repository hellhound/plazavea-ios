#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Application/Constants.h"
#import "Application/StyleSheet.h"

//color for navigation bar
#define BAR_TINT_COLOR RGBCOLOR(255, 208, 0)

//color for texts in tables
#define TABLE_TEXT_COLOR RGBCOLOR(208, 21, 26)

//logo fro navigation bar
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://general-customer-logo.png")

//launcher background
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://launcher-background.png")

@implementation StyleSheet

#pragma mark -
#pragma mark General styles

- (UIColor *)navigationBackgroundColor
{
    return BAR_TINT_COLOR;
}

- (UIColor*)navigationTextColor
{
  return TABLE_TEXT_COLOR;
}

- (UIImage *)navigationBarLogo;
{
  return NAVIGATION_BAR_LOGO;
}

#pragma mark -
#pragma mark Launcher

- (UIImageView *)launcherBackgroundImage
{
    return [[UIImageView alloc] initWithImage:NAVIGATION_BAR_LOGO];
}
@end
