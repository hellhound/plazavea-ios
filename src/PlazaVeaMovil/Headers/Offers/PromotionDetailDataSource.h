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
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol PromotionDetailDataSourceDelegate <NSObject>

- (void) dataSource:(PromotionDetailDataSource *)dataSource
     needsPromotion:(Promotion *)promotion;
- (void)dataSource:(PromotionDetailDataSource *)dataSource
     viewForHeader:(UIView *)view;
@end