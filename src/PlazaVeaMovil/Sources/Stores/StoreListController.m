#import <Foundation/Foundation.h>

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
    [_stores release];
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

@synthesize subregionId = _subregionId, regionId = _regionId, stores = _stores;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        _subregionId = [subregionId copy];
        _regionId = [regionId copy];
    }
    return self;
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
