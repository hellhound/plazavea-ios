#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/OfferDetailDataSource.h"
#import "Offers/OfferDetailController.h"

@implementation OfferDetailController

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[OfferDetailDataSource alloc]
            initWithOfferId:_offerId] autorelease]];
}

#pragma mark -
#pragma mark OfferDetailController

- (id)initWithOfferId:(NSString *)offerId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        _offerId = [offerId copy];
    }
    return self;
}
@end