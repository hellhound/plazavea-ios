#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Application/Constants.h"
#import "Application/StyleSheet.h"

//color for navigation bar
#define BAR_TINT_COLOR RGBCOLOR(255, 208, 0)

//color for texts in tables
#define TABLE_TEXT_COLOR RGBCOLOR(208, 21, 26)
#define HEADER_FONT_SIZE 20
#define HEADER_FONT_COLOR [UIColor whiteColor]

//launcher
#define LAUNCHER_BACKGROUND TTIMAGE(@"bundle://launcher-background.png")
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://logo.png")
#define NAVIGATION_BAR_COLOR RGBCOLOR(255, 208, 0)
#define LAUNCHER_FONT_COLOR RGBCOLOR(255, 180, 0)
#define LAUNCHER_FONT_SHADOW RGBCOLOR(153, 25, 28)

// nutritional composition
#define COMPOSITION_COLOR RGBCOLOR(247, 128, 31)
#define COMPOSITION_HEADER_BACKGROUND TTIMAGE(@"bundle://composition-header-background.png")

@implementation StyleSheet

#pragma mark -
#pragma mark General styles

- (UIColor *)navigationBackgroundColor
{
    return BAR_TINT_COLOR;
}

- (UIColor *)navigationTextColor
{
    return TABLE_TEXT_COLOR;
}

#pragma mark -
#pragma mark Launcher

- (TTStyle*)launcherButton:(UIControlState)state
{
    return [TTPartStyle styleWithName:@"image" 
            style:TTSTYLESTATE(launcherButtonImage:, state) next:
                [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:12]
                color:LAUNCHER_FONT_COLOR minimumFontSize:8
                shadowColor:LAUNCHER_FONT_SHADOW
                shadowOffset:CGSizeMake(.0, -1.) next:nil]];
}

- (UIImageView *)launcherBackgroundImage
{
    return [[[UIImageView alloc] initWithImage:LAUNCHER_BACKGROUND]
            autorelease];
}

- (UIImageView *)navigationBarLogo
{
    return [[[UIImageView alloc] initWithImage:NAVIGATION_BAR_LOGO]
            autorelease];
}

#pragma mark -
#pragma mark Composition

- (UIImageView *)compositionHeaderBackgroundImage
{
    return [[[UIImageView alloc] initWithImage:COMPOSITION_HEADER_BACKGROUND]
            autorelease];
}

- (UIFont *)headerFont
{
    return [UIFont boldSystemFontOfSize:HEADER_FONT_SIZE];
}

- (UIColor *)headerFontColor
{
    return HEADER_FONT_COLOR;
}

- (UIColor *)compositionSearchBarColor
{
    return COMPOSITION_COLOR;
}

@end
