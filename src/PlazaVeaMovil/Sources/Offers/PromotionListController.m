#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/PromotionListDataSource.h"
#import "Offers/PromotionListController.h"

@implementation PromotionListController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:NSLocalizedString(kPromotionListTitle, nil)];
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[PromotionListDataSource alloc] init] autorelease]];
}
@end
