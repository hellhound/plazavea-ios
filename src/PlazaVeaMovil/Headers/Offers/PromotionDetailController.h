#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FBDialog.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"

#import "Offers/Models.h"
#import "Offers/BasePromotionController.h"
#import "Offers/PromotionDetailDataSource.h"

@interface PromotionDetailController: BasePromotionController
        <PromotionDetailDataSourceDelegate, MFMailComposeViewControllerDelegate,
            FBDialogDelegate, UIAlertViewDelegate,
            SA_OAuthTwitterControllerDelegate>
{
    NSString *_promotionId;
    UIView *_headerView;
    UILabel *_titleLabel;
    TTImageView *_imageView;
    Facebook *_facebook;
    Promotion *_promotion;
    SA_OAuthTwitterEngine *_twitter;
}
@property (nonatomic, retain) Promotion *promotion;
- (id)initWithPromotionId:(NSString *)promotionId;
@end