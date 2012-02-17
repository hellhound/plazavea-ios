#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/NonEditableLauncherView.h"
#import "Application/StyleSheet.h"
#import "Launcher/Constants.h"
#import "Launcher/LauncherViewController.h"
#import "ShoppingList/Constants.h"
#import "Recipes/Constants.h"
#import "Offers/Constants.h"
#import "Stores/Constants.h"
#import "BodyMeter/Constants.h"
#import "Emergency/Constants.h"
#import "Wines/Constants.h"
#import "Composition/Constants.h"

@interface LauncherViewController (Private)

- (void)hideToolbar:(NSNumber *)animated;
@end

@implementation LauncherViewController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_launcherView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:NSLocalizedString(kLauncherTitle, nil)];
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    UIView *superView = [self view];
    _launcherView = [[NonEditableLauncherView alloc]
            initWithFrame:[superView bounds]];
    // Configuring the launcher
    [_launcherView setDelegate:self];
    [_launcherView setColumnCount:3];
    [_launcherView setPages:[NSArray arrayWithObjects:
            [NSArray arrayWithObjects:
                [[[TTLauncherItem alloc] initWithTitle:kShoppingListTitle
                    image:kURLShoppingListIcon
                    URL:kURLShoppingListsCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kRegionLauncherTitle
                    image:kURLStoresIcon
                    URL:kURLRegionListCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kOfferListTitle
                    image:kURLOffersIcon 
                    URL:kURLOfferListCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kBodyMeterTitle
                    image:kURLBodyMeterIcon 
                    URL:kURLBodyMeterDiagnosisCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kRecipeListTitle
                    image:kURLRecipesIcon
                    URL:kURLRecipeCategoriesCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kFoodCategoryTitle
                    image:kURLCompositionIcon
                    URL:kURLFoodCategory] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kSomelierTitle
                    image:kURLSomelierIcon
                    URL:kURLStrainListCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kEmergencyCategoryTitle
                    image:kURLPhonesIcon
                    URL:kURLEmergencyCategory] autorelease],
                nil],
            nil]];
    //styles
    [_launcherView setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(launcherBackgroundImage)]){
        UIImageView *backgroundView = 
                (UIImageView *)TTSTYLE(launcherBackgroundImage);

        [superView addSubview:backgroundView];
        [superView sendSubviewToBack:backgroundView];
    }

    [superView addSubview:_launcherView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                autorelease]];
    }
    if ([self toolbarItems] == nil) {
        [self performSelector:@selector(hideToolbar:)
                withObject:[NSNumber numberWithBool:animated]
                afterDelay:kLauncherToolbarDelay];
    }
}

#pragma mark -
#pragma mark LauncherViewController (Private)

- (void)hideToolbar:(NSNumber *)animated
{
    [[self navigationController] setToolbarHidden:YES
            animated:[animated boolValue]];
}

#pragma mark -
#pragma mark <TTLauncherViewDelegate>

- (void)launcherView:(TTLauncherView *)launcherView
       didSelectItem:(TTLauncherItem *)item
{
    [[TTNavigator navigator] openURLAction:
            [[TTURLAction actionWithURLPath:[item URL]] applyAnimated:YES]];
}
@end
