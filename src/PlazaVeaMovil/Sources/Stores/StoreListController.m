#import <Foundation/Foundation.h>

#import "Stores/Constants.h"
#import "Stores/StoreListDataSource.h"
#import "Stores/StoreListController.h"

@implementation StoreListController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
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

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StoreListDataSource alloc]
            initWithSubregionId:_subregionId] autorelease]];
}

#pragma mark -
#pragma mark StoreListController (Public)

@synthesize subregionId = _subregionId;

- (id)initWithSubregionId:(NSString *)subregionId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _subregionId = [subregionId copy];
    }
    return self;
}
@end
