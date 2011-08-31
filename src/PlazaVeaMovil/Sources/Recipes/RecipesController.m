#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"
#import "Recipes/RecipesController.h"

@implementation RecipesController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:kRecipesTitle];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    if ([self toolbarItems] == nil) {
        // Conf the segmented control
        UISegmentedControl *segControl =
                [[[UISegmentedControl alloc] initWithItems:
                    [NSArray arrayWithObjects:kRecipesFoodButton,
                        kRecipesMeatTypesButton, nil]] autorelease];
        UIBarButtonItem *segItem = [[[UIBarButtonItem alloc]
                initWithCustomView:segControl] autorelease];

        [segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        [segControl setSelectedSegmentIndex:
                kRecipesSegmentedControlIndexDefault];

        // Conf a spacer
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                target:nil action:NULL] autorelease];

        [self setToolbarItems:[NSArray arrayWithObjects:
                spacerItem, segItem, spacerItem, nil]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[AlphabeticalRecipesDataSource alloc] init] autorelease]];
}
@end
