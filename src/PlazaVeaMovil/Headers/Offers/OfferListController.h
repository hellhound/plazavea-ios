#import <Foundation/Foundation.h>

#import "Offers/OfferListDataSource.h"
#import "Offers/BaseOfferController.h"

@interface OfferListController: BaseOfferController
        <OfferListDataSourceDelegate>
{
    NSNumber *_bannerId;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@end