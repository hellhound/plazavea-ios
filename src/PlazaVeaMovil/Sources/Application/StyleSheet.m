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
#define HEADER_COLOR_WHITE [UIColor whiteColor]

//size for text in tables
#define TABLE_TEXT_HEADER_SIZE 16
#define PICTURE_HEADER_SIZE 14
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

// nutritional composition
#define COMPOSITION_BACKGROUND TTIMAGE(@"bundle://composition-background.png")
#define COMPOSITION_PICTURE_BACKGROUND \
        TTIMAGE(@"bundle://composition-picture-background.png")
#define COMPOSITION_SECTION_HEADER_BACKGROUND \
        TTIMAGE(@"bundle://composition-section-header.png")
#define COMPOSITION_SEARCHBAR_COLOR RGBCOLOR(247, 128, 31)

// emergency phones
#define EMERGENCY_BACKGROUND TTIMAGE(@"bundle://emergency-background.png")
#define EMERGENCY_SECTION_HEADER \
        TTIMAGE(@"bundle://emergency-section-header.png");
#define EMERGENCY_SEARCHBAR_COLOR RGBCOLOR(227, 13, 23)

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

- (UIColor *)headerColorYellow
{
    return HEADER_COLOR_YELLOW;
}

- (UIColor *)headerColorWhite
{
    return HEADER_COLOR_WHITE;
}

- (UIFont *)tableTextHeaderFont
{
    return [UIFont boldSystemFontOfSize:TABLE_TEXT_HEADER_SIZE];
}

- (UIFont *)tableTextFont
{
    return [UIFont boldSystemFontOfSize:TABLE_TEXT_SIZE];
}

- (UIFont *)pictureHeaderFont
{
    return [UIFont boldSystemFontOfSize:PICTURE_HEADER_SIZE];
}

- (UIFont *)tableSummaryFont
{
    return [UIFont boldSystemFontOfSize:TABLE_TEXT_HEADER_SIZE];
}

- (UIColor *)tableHeaderTintColor
{
    return EMERGENCY_SEARCHBAR_COLOR;
}

- (UIColor *)tableHeaderTextColor
{
    return HEADER_COLOR_WHITE;
}

#pragma mark -
#pragma mark Launcher

- (TTStyle *)launcherButton:(UIControlState)state
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

- (UIImage *)shopingListBackgroundHeader
{
    return SHOPPING_LIST_BACKGROUND;
}

#pragma mark -
#pragma mark Composition

- (UIImage *)compositionBackgroundHeader
{
    return COMPOSITION_BACKGROUND;
}

- (UIImage *)compositionPictureBackground
{
    return COMPOSITION_PICTURE_BACKGROUND;
}

- (UIImage *)compositionSectionHeaderBackground
{
    return COMPOSITION_SECTION_HEADER_BACKGROUND;
}

- (UIColor *)compositionSearchBarColor
{
    return COMPOSITION_SEARCHBAR_COLOR;
}

#pragma mark -
#pragma mark Emergency

- (UIImage *)emergencyBackgroundHeader
{
    return EMERGENCY_BACKGROUND;
}

- (UIImage *)emergencySectionHeaderBackground
{
    return EMERGENCY_SECTION_HEADER;
}

- (UIColor *)emergencySearchBarColor
{
    return EMERGENCY_SEARCHBAR_COLOR;
}
@end
