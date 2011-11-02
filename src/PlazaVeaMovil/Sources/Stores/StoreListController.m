#import <Foundation/Foundation.h>

#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/StoreListDataSource.h"
#import "Stores/StoreListController.h"

@implementation StoreListController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_regionId release];
    [_subregionId release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kStoreListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if ([self toolbarItems] != nil) {
        for (UIBarButtonItem *item in [self toolbarItems]) {
            if ([[item customView] isKindOfClass:[UISegmentedControl class]]) {
                [(UISegmentedControl *)[item customView] addTarget:self
                        action:@selector(switchControllers:)
                            forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StoreListDataSource alloc]
            initWithSubregionId:_subregionId andRegionId:_regionId
                delegate:self] autorelease]];
}

#pragma mark -
#pragma mark StoreListController (Public)

@synthesize subregionId = _subregionId, regionId = _regionId;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        _subregionId = [subregionId copy];
        _regionId = [regionId copy];
    }
    return self;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [[TTNavigator navigator] openURLAction:[[TTURLAction
                    actionWithURLPath:URL(kURLStoreMapCall, _subregionId,
                        _regionId)] applyAnimated:YES]];
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}
@end
