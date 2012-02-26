#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FBDialog.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"

#import "Offers/Models.h"
#import "Offers/BaseOfferController.h"
#import "Offers/OfferDetailDataSource.h"

@interface OfferDetailController: BaseOfferController
        <OfferDetailDataSourceDelegate, MFMailComposeViewControllerDelegate,
            FBDialogDelegate, UIAlertViewDelegate,
            SA_OAuthTwitterControllerDelegate>
{
    NSString *_offerId;
    Facebook *_facebook;
    Offer *_offer;
    SA_OAuthTwitterEngine *_twitter;
}
@property (nonatomic, retain) Offer *offer;
@property (nonatomic, retain) NSString *offerId;
- (id)initWithOfferId:(NSString *)offerId;
@end
