#import <Foundation/Foundation.h>

#import "Wines/Constants.h"
#import "Wines/StrainListDataSource.h"
#import "WInes/StrainListController.h"

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
}@end