#import <Foundation/Foundation.h>

#import "Recipes/Constants.h"
#import "Recipes/MeatListDataSource.h"
#import "Recipes/MeatListController.h"

@implementation MeatListController

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:NSLocalizedString(kRecipesMeatTypesButton, nil)];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[MeatListDataSource alloc] init] autorelease]];
}


@end