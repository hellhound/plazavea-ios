#import <Foundation/Foundation.h>

#import "Wines/Constants.h"
#import "Wines/StrainListDataSource.h"
#import "Wines/StrainListController.h"

@implementation StrainListController

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kStrainListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StrainListDataSource alloc] init] autorelease]];
}
@end