#import <Foundation/Foundation.h>

#import "Stores/Constants.h"
#import "Stores/RegionListDataSource.h"
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
    [self setDataSource:[[[RegionListDataSource alloc] init] autorelease]];
}
@end