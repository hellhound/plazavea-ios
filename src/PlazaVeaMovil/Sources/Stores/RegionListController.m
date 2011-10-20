#import <Foundation/Foundation.h>

#import "Stores/Constants.h"
#import "Stores/RegionListDataSource.h"
#import "Stores/SubregionDataSource.h"
#import "Stores/RegionListController.h"

@implementation RegionListController

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kRegionListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if (_regionId != nil) {
        [self setDataSource:[[[SubregionDataSource alloc]
                initWithRegionId:_regionId] autorelease]];
    } else {
        [self setDataSource:[[[RegionListDataSource alloc] init] autorelease]];
    }
}


#pragma mark -
#pragma mark RegionListController (Public)

@synthesize regionId = _regionId;

- (id)initWithRegionId:(NSString *)regionId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _regionId = [regionId copy];
    }
    return self;
}
@end