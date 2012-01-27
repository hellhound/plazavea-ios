#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Offers/Models.h"

@protocol OfferDetailDataSourceDelegate;

@interface OfferDetailDataSource: TTListDataSource
{
    id<OfferDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithOfferId:(NSString *)offerId
              delegate:(id<OfferDetailDataSourceDelegate>)delegate;
@end

@protocol OfferDetailDataSourceDelegate <NSObject>
- (void)        dataSource:(OfferDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title;
- (void)dataSource:(OfferDetailDataSource *)dataSource
        needsOffer:(Offer *)offer;
@end
