#import <Foundation/Foundation.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"
#import "Offers/OfferListDataSource.h"
#import "Offers/OfferListController.h"

@interface OfferListController ()

@property (nonatomic, retain) NSNumber *bannerId;
@end

@implementation OfferListController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_bannerId release];
    [super dealloc];
}

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

- (void)createModel
{
    [self setDataSource:[[[OfferListDataSource alloc] initWithListDelegate:self]
            autorelease]];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[TTNavigator navigator] openURLAction: [[TTURLAction actionWithURLPath:
                URL(kURLOfferDetailCall, _bannerId)] applyAnimated:YES]];
    }
}

#pragma mark -
#pragma mark OfferListController (Private)

@synthesize bannerId = _bannerId;

#pragma mark -
#pragma mark <OfferListDataSourceDelegate>

- (void)    dataSource:(OfferListDataSource *)dataSource
needsBannerId:(NSNumber *)bannerId
{
    [self setBannerId:bannerId];
}
@end