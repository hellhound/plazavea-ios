#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Launcher/Constants.h"
#import "Launcher/LauncherViewController.h"
#import "ShoppingList/Constants.h"
#import "Recipes/Constants.h"
#import "Offers/Constants.h"
#import "Stores/Constants.h"

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

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    UINavigationController *navController = [self navigationController];

    if ([navItem titleView] == nil){
        UIImageView *logoTypeView = 
                [[[UIImageView alloc] initWithImage:LOGOTYPE] autorelease];
        [navItem setTitleView:logoTypeView];
    }
    [[navController navigationBar] setTintColor:BAR_COLOR];
    [[navController toolbar] setTintColor:BAR_COLOR];
    return navItem;
}

- (void)loadView
{
    [super loadView];

    UIView *superView = [self view];

    _launcherView = [[TTLauncherView alloc] initWithFrame:[superView bounds]];
    // Configuring the launcher
    [_launcherView setBackgroundColor:[UIColor whiteColor]];
    [_launcherView setDelegate:self];
    [_launcherView setColumnCount:3];
    [_launcherView setPages:[NSArray arrayWithObjects:
            [NSArray arrayWithObjects:
                [[[TTLauncherItem alloc] initWithTitle:kShoppingListTitle
                    image:kURLShoppingListIcon
                    URL:kURLShoppingListsCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kRecipeListTitle
                    image:kURLRecipesIcon
                    URL:kURLRecipeCategoriesCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kOfferListTitle
                    image:kURLOffersIcon 
                    URL:kURLOfferListCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kRegionListTitle
                    image:kURLStoresIcon
                    URL:kURLRegionListCall] autorelease],
                nil],
            nil]];
    [superView addSubview:_launcherView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
