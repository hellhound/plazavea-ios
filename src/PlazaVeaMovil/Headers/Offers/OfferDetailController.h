#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FBDialog.h"

#import "Offers/BaseOfferController.h"
#import "Offers/OfferDetailDataSource.h"

@interface OfferDetailController: BaseOfferController
        <OfferDetailDataSourceDelegate, MFMailComposeViewControllerDelegate,
            FBSessionDelegate, FBDialogDelegate>
{
    NSString *_offerId;
    UIView *_headerView;
    UILabel *_titleLabel;
    TTImageView *_imageView;
    Facebook *_facebook;
}

- (id)initWithOfferId:(NSString *)offerId;
@end
