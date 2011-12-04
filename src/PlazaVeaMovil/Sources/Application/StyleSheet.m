#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Application/Constants.h"
#import "Application/StyleSheet.h"

//color for navigation bar
#define BAR_TINT_COLOR RGBCOLOR(255, 208, 0)

//color for texts in tables
#define TABLE_TEXT_COLOR RGBCOLOR(0, 0, 0)

//color for Headers
#define HEADER_COLOR_YELLOW RGBCOLOR(255, 255, 0)

//size for text in tables
#define TABLE_TEXT_HEADER_SIZE 16
#define TABLE_TEXT_SIZE 13

//launcher
#define LAUNCHER_BACKGROUND TTIMAGE(@"bundle://launcher-background.png")
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://general-customer-logo.png")
#define NAVIGATION_BAR_COLOR RGBCOLOR(255, 208, 0)
#define LAUNCHER_FONT_COLOR RGBCOLOR(255, 180, 0)
#define LAUNCHER_FONT_SHADOW RGBCOLOR(153, 25, 28)

//shopping list
#define SHOPPING_LIST_BACKGROUND \
    TTIMAGE(@"bundle://shopping-list-background.png")

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

- (UIColor*)headerColorYellow
{
    return HEADER_COLOR_YELLOW;
}

- (UIFont *)tableTextHeaderFont
{
    return [UIFont boldSystemFontOfSize:TABLE_TEXT_HEADER_SIZE];
}

- (UIFont *)tableTextFont
{
    return [UIFont boldSystemFontOfSize:TABLE_TEXT_SIZE];
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
    return [[[UIImageView alloc] 
        initWithImage:LAUNCHER_BACKGROUND] autorelease];
}

- (UIImage *)navigationBarLogo
{
    return NAVIGATION_BAR_LOGO;
}

#pragma mark -
#pragma mark ShoppingLists

- (UIImageView *)shopingListBackgroundHeader
{
    return [[[UIImageView alloc] 
        initWithImage:SHOPPING_LIST_BACKGROUND] autorelease];
}
@end
