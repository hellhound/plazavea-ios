#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Stores/Constants.h"
#import "Stores/StoreMapTogglingController.h"

@interface StoreMapTogglingController ()

@property (nonatomic, readonly) UISegmentedControl *segControl;

- (void)switchControllers:(UISegmentedControl *)segControl;
@end

@implementation StoreMapTogglingController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_segControl release];
    [_stores release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
    }
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
#pragma mark StoreMapTogglingController (Private)

@synthesize segControl = _segControl;

- (UISegmentedControl *)segControl
{
    if (_segControl != nil)
        return _segControl;
    // Conf the segmented control
    [_segControl autorelease];
    _segControl = [[UISegmentedControl alloc] initWithItems:
            [NSArray arrayWithObjects:kStoreListButtonLabel,
                kStoreMapButtonLabel, nil]];
    [_segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segControl setSelectedSegmentIndex:kStoreSegmentedControlIndexDefault];
    [_segControl addTarget:self action:@selector(switchControllers:)
          forControlEvents:UIControlEventValueChanged];
    return _segControl;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [[TTNavigator navigator] openURLAction:
             [[TTURLAction actionWithURLPath: kURLStoreMap] applyAnimated:YES]];
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}

#pragma mark -
#pragma mark StoreMapTogglingController (Public)

@synthesize segmentIndex = _segmentIndex, stores = _stores;

- (void)setSegmentIndex:(NSInteger)segmentedIndex
{
    UISegmentedControl *segControl = [self segControl];
    
    [segControl removeTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
    [segControl setSelectedSegmentIndex:segmentedIndex];
    [segControl addTarget:self action:@selector(switchControllers:)
         forControlEvents:UIControlEventValueChanged];
}

#pragma mark -
#pragma mark <StoreListDataSourceDelegate>

- (void)    dataSource:(StoreListDataSource *)dataSource
  needsStoreCollection:(NSArray *)stores
{
    NSMutableArray *unlistedStores =
    [NSMutableArray arrayWithCapacity:[stores count]];
    
    for (NSArray *sections in stores) {
        for (Store *store in sections) {
            [unlistedStores addObject:store];
        }
    }
    [self setStores:unlistedStores];
}
@end
