#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/BaseOfferController.h"
#import "Offers/OfferDetailDataSource.h"

@interface OfferDetailController: BaseOfferController
        <OfferDetailDataSourceDelegate>
{
    NSString *_offerId;
    UIView *_headerView;
    UILabel *_titleLabel;
    TTImageView *_imageView;
}

- (id)initWithOfferId:(NSString *)offerId;
@end
