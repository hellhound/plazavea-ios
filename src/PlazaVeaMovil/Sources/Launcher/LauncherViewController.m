#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Launcher/LauncherViewController.h"

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
                [[[TTLauncherItem alloc] initWithTitle:@"Mis listas"
                    image:@"bundle://recipeBook.png"
                    URL:@"tt://launcher/shoppinglists/"] autorelease],
                nil],
            nil]];
    [superView addSubview:_launcherView];
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
