#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Launcher/Constants.h"
#import "Launcher/LauncherViewController.h"
#import "ShoppingList/Constants.h"
#import "Recipes/Constants.h"

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
        [self setTitle:NSLocalizedString(@"Plaza Vea Móvil :)", nil)];
    }
    return self;
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
                    URL:kURLShoppingListCall] autorelease],
                [[[TTLauncherItem alloc] initWithTitle:kRecipesTitle
                    image:kURLRecipesIcon
                    URL:nil] autorelease],
                nil],
            nil]];
    [superView addSubview:_launcherView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(hideToolbar:)
            withObject:[NSNumber numberWithBool:animated]
            afterDelay:kLauncherToolbarDelay];
}

#pragma mark -
#pragma mark LauncherViewController (Private)

- (void)hideToolbar:(NSNumber *)animated
{
    [[self navigationController] setToolbarHidden:YES animated:YES];
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
