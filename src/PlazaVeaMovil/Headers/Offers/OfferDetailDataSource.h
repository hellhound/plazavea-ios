#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol OfferDetailDataSourceDelegate <NSObject>

- (void)dataSource:(OfferDetailDataSource *)dataSource
        needsOffer:(Offer *)offer;
- (void)dataSource:(OfferDetailDataSource *)dataSource
     viewForHeader:(UIView *)view;
@end
