#import <Foundation/Foundation.h>

#import "Offers/Constants.h"
#import "Offers/OfferListDataSource.h"
#import "Offers/OfferListController.h"

@implementation OfferListController

#pragma mark -
#pragma mark UIView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kOfferListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void) createModel
{
    [self setDataSource:[[[OfferListDataSource alloc] init] autorelease]];
}
@end