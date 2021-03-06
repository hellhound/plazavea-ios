#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Application/Constants.h"
#import "Application/StyleSheet.h"

// default status bar style
#define STATUS_BAR_STYLE UIStatusBarStyleBlackOpaque

// color for navigation bar
#define BAR_TINT_COLOR RGBCOLOR(255., 208., .0)

// color for texts in tables
#define TABLE_TEXT_COLOR RGBCOLOR(.0, .0, .0)
#define CAPTION_ALT_COLOR RGBCOLOR(227., 13., 23.)
#define DETAIL_ALT_COLOR RGBCOLOR(.0, .0, .0)

// color for Headers
#define HEADER_COLOR_YELLOW RGBCOLOR(255., 255., .0)
#define HEADER_COLOR_WHITE [UIColor whiteColor]

// size for text in tables
#define TABLE_TEXT_HEADER_SIZE 16.
#define TABLE_SECTION_HEADER_HEIGHT 24.
#define PICTURE_HEADER_SIZE 14.
#define TABLE_TEXT_SIZE 13.

// launcher
#define LAUNCHER_BACKGROUND TTIMAGE(@"bundle://launcher-background.png")
#define NAVIGATION_BAR_LOGO TTIMAGE(@"bundle://general-customer-logo.png")
#define NAVIGATION_BAR_COLOR RGBCOLOR(255., 208., .0)
#define LAUNCHER_FONT_COLOR RGBCOLOR(255., 180., .0)
#define LAUNCHER_FONT_SHADOW RGBCOLOR(153., 25., 28.)

// shopping list
#define SHOPPING_LIST_BACKGROUND \
    TTIMAGE(@"bundle://shopping-list-background.png")
#define SHOPPING_LIST_ICON_ADD \
    TTIMAGE(@"bundle://shopping-list-add.png")

#define TOOLBAR_PREVIOUS_ICON TTIMAGE(@"bundle://toolbar-previous-icon.png") 
#define TOOLBAR_NEXT_ICON TTIMAGE(@"bundle://toolbar-next-icon.png") 
#define TOOLBAR_ADD_ICON TTIMAGE(@"bundle://shopping-list-add.png") 
#define TOOLBAR_ACTION_ICON TTIMAGE(@"bundle://toolbar-action-icon.png") 
#define TOOLBAR_TRASH_ICON TTIMAGE(@"bundle://toolbar-trash-icon.png") 
#define SHOPPINGLISTS_SEARCHBAR_COLOR RGBCOLOR(227., 13., 23.)

// nutritional composition
#define COMPOSITION_BACKGROUND TTIMAGE(@"bundle://composition-background.png")
#define COMPOSITION_PICTURE_BACKGROUND \
        TTIMAGE(@"bundle://composition-picture-background.png")
#define COMPOSITION_SECTION_HEADER_BACKGROUND \
        TTIMAGE(@"bundle://composition-section-header.png")
#define COMPOSITION_SEARCHBAR_COLOR RGBCOLOR(247., 128., 31.)
#define CORDON_BLEU_LOGO TTIMAGE(@"bundle://logo-cordon-bleu.png")

// emergency phones
#define EMERGENCY_BACKGROUND TTIMAGE(@"bundle://emergency-background.png")
#define EMERGENCY_SECTION_HEADER \
        TTIMAGE(@"bundle://emergency-section-header.png")
#define EMERGENCY_SEARCHBAR_COLOR RGBCOLOR(227., 13., 23.)

// stores
#define STORES_BACKGROUND TTIMAGE(@"bundle://stores-background.png")
#define STORES_SECTION_HEADER TTIMAGE(@"bundle://stores-section-header.png")

// offers
#define OFFER_BACKGROUND TTIMAGE(@"bundle://offer-background.png")

// recipes
#define RECIPES_BACKGROUND TTIMAGE(@"bundle://recipes-background.png")
#define MEATS_BACKGROUND TTIMAGE(@"bundle://meats-background.png")
#define RECIPES_SECTION_HEADER TTIMAGE(@"bundle://recipes-section-header.png")
#define MEATS_SECTION_HEADER TTIMAGE(@"bundle://meats-section-header.png")
#define RECIPE_DETAIL_BACKGROUND \
        TTIMAGE(@"bundle://recipes-picture-background.png")

// wines
#define WINE_BACKGROUND TTIMAGE(@"bundle://wine-background.png")
#define WINE_SECTION_HEADER TTIMAGE(@"bundle://wine-section-header.png")

// body meter
#define FOOTER_FONT_COLOR RGBCOLOR(60., 69., 87.)

@implementation StyleSheet

#pragma mark -
#pragma mark General styles

- (UIStatusBarStyle)statusBarStyle
{
    return STATUS_BAR_STYLE;
}

- (UIColor *)navigationBarTintColor
{
    return BAR_TINT_COLOR;
}

- (UIColor *)toolbarTintColor
{
    return BAR_TINT_COLOR;
}

- (UIColor *)captionAltColor
{
    return CAPTION_ALT_COLOR;
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

- (CGFloat)heightForTableSectionHeaderView
{
    return TABLE_SECTION_HEADER_HEIGHT;
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

- (UIImage *)barButtonPreviousIcon
{
    return TOOLBAR_PREVIOUS_ICON;
}

- (UIImage *)barButtonNextIcon
{
    return TOOLBAR_NEXT_ICON;
}

- (UIImage *)barButtonAddIcon
{
    return TOOLBAR_ADD_ICON;
}

- (UIImage *)barButtonActionIcon
{
    return TOOLBAR_ACTION_ICON;
}

- (UIImage *)barButtonTrashIcon
{
    return TOOLBAR_TRASH_ICON;
}

- (UIColor *)shoppingListsSearchBarColor
{
    return SHOPPINGLISTS_SEARCHBAR_COLOR;
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

- (UIImage *)cordonBleuLogo
{
    return CORDON_BLEU_LOGO;
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

#pragma mark -
#pragma mark Stores

- (UIImage *)storesBackgroundHeader
{
    return STORES_BACKGROUND;
}

- (TTStyle *)storesSectionHeader
{
    return [TTImageStyle styleWithImage:STORES_SECTION_HEADER next:nil];
}

#pragma mark -
#pragma mark Offer

- (UIImage *)offerBackgroundHeader
{
    return OFFER_BACKGROUND;
}

#pragma mark -
#pragma mark Recipes

- (UIImage *)recipesBackgroundHeader
{
    return RECIPES_BACKGROUND;
}

- (TTStyle *)recipesSectionHeader
{
    return  [TTImageStyle styleWithImage:RECIPES_SECTION_HEADER next:nil];
}

- (UIImage *)meatsBackgroundHeader
{
    return MEATS_BACKGROUND;
}

- (TTStyle *)meatsSectionHeader
{
    return  [TTImageStyle styleWithImage:MEATS_SECTION_HEADER next:nil];
}

- (UIImage *)recipePictureBackground
{
    return RECIPE_DETAIL_BACKGROUND;
}

#pragma mark -
#pragma mark Wines

- (UIImage *)wineBackgroundHeader
{
    return WINE_BACKGROUND;
}

- (TTStyle *)wineSectionHeader
{
    return [TTImageStyle styleWithImage:WINE_SECTION_HEADER next:nil];
}

#pragma mark -
#pragma mark BodyMeter

- (UIColor *)footerFontColor
{
    return FOOTER_FONT_COLOR;
}
@end
