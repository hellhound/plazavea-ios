#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Offers/Models.h"

@protocol PromotionDetailDataSourceDelegate;

@interface PromotionDetailDataSource: TTListDataSource
{
    id<PromotionDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithPromotionId:(NSString *)promotionId
                 delegate:(id<PromotionDetailDataSourceDelegate>)delegate;
@end

@protocol PromotionDetailDataSourceDelegate <NSObject>
- (void)        dataSource:(PromotionDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title;
- (void) dataSource:(PromotionDetailDataSource *)dataSource
     needsPromotion:(Promotion *)promotion;
@end