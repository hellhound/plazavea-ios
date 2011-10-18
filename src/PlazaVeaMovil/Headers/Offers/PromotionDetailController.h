#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/BasePromotionController.h"
#import "Offers/PromotionDetailDataSource.h"

@interface PromotionDetailController: BasePromotionController
        <PromotionDetailDataSourceDelegate>
{
    NSString *_promotionId;
    UIView *_headerView;
    UILabel *_titleLabel;
    TTImageView *_imageView;
}

- (id)initWithPromotionId:(NSString *)promotionId;
@end