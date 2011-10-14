#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/BaseOfferController.h"
#import "Offers/OfferDetailDataSource.h"

@interface OfferDetailController: BaseOfferController
{
    NSString *_offerId;
}

- (id)initWithOfferId:(NSString *)offerId;
@end