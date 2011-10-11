#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/RecipeDrillDownController.h"

@interface RecipeDrillDownController ()

@property (nonatomic, readonly) UISegmentedControl *segControl;

- (void)switchControllers:(UISegmentedControl *)segControl;
@end

@implementation RecipeDrillDownController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_segControl release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTableViewStyle:UITableViewStylePlain];
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    if ([self toolbarItems] == nil) {
        // Conf the segmented item
        UIBarButtonItem *segItem = [[[UIBarButtonItem alloc]
                initWithCustomView:[self segControl]] autorelease];
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
#pragma mark RecipeDrillDownController (Private)

@synthesize segControl = _segControl;

- (UISegmentedControl *)segControl
{
    if (_segControl != nil)
        return _segControl;
    // Conf the segmented control
    [_segControl autorelease];
    _segControl = [[UISegmentedControl alloc] initWithItems:
                [NSArray arrayWithObjects:kRecipesFoodButton,
                    kRecipesMeatTypesButton, nil]];
    [_segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segControl setSelectedSegmentIndex:
            kRecipesSegmentedControlIndexDefault];
    [_segControl addTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
    return _segControl;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kRecipesSegmentedControlIndexMeatButton:
            [[TTNavigator navigator] openURLAction:
                    [[TTURLAction actionWithURLPath:
                        kURLMeatsCall] applyAnimated:YES]];
            break;
        case kRecipesSegmentedControlIndexFoodButton:
            [[TTNavigator navigator] openURLAction:
                    [[TTURLAction actionWithURLPath:
                        kURLRecipeCategoriesCall] applyAnimated:YES]];
            break;
    }
}

#pragma mark -
#pragma mark RecipeDrillDownController (Public)

@synthesize defaultSegmentIndex = _defaultSegmentIndex;

- (void)setDefaultSegmentIndex:(NSInteger)defaultSegmentIndex
{
    UISegmentedControl *segControl = [self segControl];

    [segControl removeTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
    [segControl setSelectedSegmentIndex:defaultSegmentIndex]; 
    [segControl addTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
}
@end
