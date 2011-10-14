#import <Foundation/Foundation.h>

#import "Launcher/Constants.h"
#import "Recipes/Constants.h"
#import "Recipes/MeatListDataSource.h"
#import "Recipes/MeatListController.h"

@implementation MeatListController

#pragma mark -
#pragma mark UIViewController

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
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:NSLocalizedString(kRecipesMeatTypesButton, nil)];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[MeatListDataSource alloc] init] autorelease]];
}

#pragma mark -
#pragma mark MeatListController

- (void)popToNavigationWindow{
    [self dismissModalViewControllerAnimated:YES];
    [(UINavigationController *)
            [[self parentViewController] parentViewController]
                popToRootViewControllerAnimated:NO];
}
@end
