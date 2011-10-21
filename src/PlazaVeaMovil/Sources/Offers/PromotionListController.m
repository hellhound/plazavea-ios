#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/UIDevice+Additions.h"
#import "Launcher/Constants.h"
#import "Offers/Constants.h"
#import "Offers/PromotionListDataSource.h"
#import "Offers/PromotionListController.h"

@implementation PromotionListController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:NSLocalizedString(kPromotionListTitle, nil)];
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    if (_backButton == nil) {
        _backButton = [[UIBarButtonItem alloc]
                initWithTitle:NSLocalizedString(
                    kLauncherTitle, nil)
                style:UIBarButtonItemStylePlain target:self
               action:@selector(popToNavigationWindow)];
        [navItem setLeftBarButtonItem:_backButton];
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[PromotionListDataSource alloc] init] autorelease]];
}

#pragma mark -
#pragma mark MeatListController

- (void)popToNavigationWindow
{
    [self dismissModalViewControllerAnimated:YES];
    if ([[UIDevice currentDevice] deviceSystemVersion] > kSystemVersion4) {
        [(UINavigationController *)
                [[self parentViewController] performSelector:
                        @selector(presentingViewController)]
                    popToRootViewControllerAnimated:NO];
    } else {
        [(UINavigationController *)
                [[self parentViewController] parentViewController]
                    popToRootViewControllerAnimated:NO];
    }
}
@end
