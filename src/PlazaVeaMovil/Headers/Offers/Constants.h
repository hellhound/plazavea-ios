//Offers module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Offer model's constants

// JSON keys
extern NSString *const kOfferIdKey;
extern NSString *const kOfferCodeKey;
extern NSString *const kOfferNameKey;
extern NSString *const kOfferDescriptionKey;
extern NSString *const kOfferLegaleseKey;
extern NSString *const kOfferPriceKey;
extern NSString *const kOfferDiscountKey;
extern NSString *const kOfferOldPriceKey;
extern NSString *const kOfferValidFromKey;
extern NSString *const kOfferValidToKey;
extern NSString *const kOfferPictureURLKey;
extern NSString *const kOfferExtraPictureURLsKey;
extern NSString *const kOfferFacebookURLKey;
extern NSString *const kOfferTwitterURLKey;

// Offer collection model's constants

// JSON keys
extern NSString *const kOfferCollectionOffersKey;
extern NSString *const kOfferCollectionBannerKey;

// Banner model's constant

//JSON keys
extern NSString *const kBannerIdKey;
extern NSString *const kBannerPictureURLKey;
extern NSString *const kBannerStartKey;
extern NSString *const kBannerEndKey;

// Promotion model's constants

//JSON keys
extern NSString *const kPromotionIdKey;
extern NSString *const kPromotionCodeKey;
extern NSString *const kPromotionNameKey;
extern NSString *const kPromotionBannerURLKey;
extern NSString *const kPromotionDescriptionKey;
extern NSString *const kPromotionLegaleseKey;
extern NSString *const kPromotionValidFromKey;
extern NSString *const kPromotionValidToKey;
extern NSString *const kPromotionExtraPictureURLsKey;
extern NSString *const kPromotionFacebookURLKey;
extern NSString *const kPromotionTwitterURLKey;

// Promotion collection model's constants

// JSON keys
extern NSString *const kPromotionCollectionPromotions;

// OfferListDataSource's constants

// Messages
extern NSString *const kOfferListTitleForLoading;
extern NSString *const kOfferListTitleForReloading;
extern NSString *const kOfferListTitleForEmpty;
extern NSString *const kOfferListSubtitleForEmpty;
extern NSString *const kOfferListTitleForError;
extern NSString *const kOfferListSubtitleForError;

extern NSString *const kOfferListDefaultImage;
extern NSString *const kOfferListPriceTag;

// OfferDetailDataSource's constants

// Messages
extern NSString *const kOfferDetailTitleForLoading;
extern NSString *const kOfferDetailTitleForEmpty;
extern NSString *const kOfferDetailSubtitleForEmpty;
extern NSString *const kOfferDetailTitleForError;
extern NSString *const kOfferDetailSubtitleForError;
extern NSString *const kOfferDetailOldPriceCaption;
extern NSString *const kOfferDetailPriceCaption;
extern NSString *const kOfferDetailValidCaption;
extern NSString *const kOfferDetailPricePrefix;
extern NSString *const kOfferDetailValidPrefix;
extern NSString *const kOfferDetailLegaleseCaption;

// PromotionListDataSource's constants

// Messages
extern NSString *const kPromotionListTitleForLoading;
extern NSString *const kPromotionListTitleForReloading;
extern NSString *const kPromotionListTitleForEmpty;
extern NSString *const kPromotionListSubtitleForEmpty;
extern NSString *const kPromotionListTitleForError;
extern NSString *const kPromotionListSubtitleForError;

extern const CGFloat kPromotionListImageWidth;
extern const CGFloat kPromotionListImageHeight;
extern NSString *const kPromotionListDefaultBanner;

// PromotionDetailDataSource's constants

//Messages
extern NSString *const kPromotionDetailTitleForLoading;
extern NSString *const kPromotionDetailTitleForReloading;
extern NSString *const kPromotionDetailTitleForEmpty;
extern NSString *const kPromotionDetailSubtitleForEmpty;
extern NSString *const kPromotionDetailTitleForError;
extern NSString *const kPromotionDetailSubtitleForError;
extern NSString *const kPromotionDetailLegaleseCaption;

// OfferDrillDownController's constants

typedef enum {
    kOfferSegmentedControlIndexOfferButton,
    kOfferSegmentedControlIndexPromotionButton,
    kOfferSegmentedControlIndexDefault =
        kOfferSegmentedControlIndexOfferButton
}OfferSegmentedControlIndexTypes;

//UISegmentedControl item's label for the toolbar: promo button
extern NSString *const kOfferPromotionButtonLabel;
//UISegmentedControl item's label for the toolbar: offers button
extern NSString *const kOfferButtonLabel;

// OfferListController's constants

extern NSString *const kOfferListTitle;
extern NSString *const kBannerDefaultImage;
extern NSString *const kOfferBannerDefaultImage;
extern const CGFloat kBannerImageWidth;
extern const CGFloat kBannerImageHeight;
extern const CGFloat kOfferListImageWidth;
extern const CGFloat kOfferListImageHeight;

// OfferDetailController's constants

extern NSString *const kOfferDetailTitle;
extern const CGFloat kOfferDetailBackground;
extern const CGFloat kOfferDetailImageWidth;
extern const CGFloat kOfferDetailImageHeight;
extern NSString *const kOfferDetailDefaultImage;
extern NSString *const kOfferDetailShare;
extern NSString *const kOfferDetailMailImage;
extern NSString *const kOfferDetailFacebookImage;
extern NSString *const kOfferDetailTwitterImage;
extern NSString *const kTwitterAlertTitle;
extern NSString *const kTwitterAlertCancel;
extern NSString *const kTwitterAlertSend;
extern NSString *const kTwitterAlertMessage;
extern NSString *const kFBLink;
extern NSString *const kFBPicture;
extern NSString *const kFBCaption;
extern NSString *const kFBDescription;
extern NSString *const kFBFeedDialog;
extern NSString *const kMailBanner;
extern const CGFloat kMailBannerWidth;
extern const CGFloat kMailBannerHeight;

// PromotionListController's constants

extern NSString *const kPromotionListTitle;

// PromotionDetailController's constants
extern NSString *const kPromotionDetailTitle;
extern const CGFloat kPromotionDetailImageWidth;
extern const CGFloat kPromotionDetailImageHeight;

//Controllers' URL
extern NSString *const kURLOfferList;
extern NSString *const kURLOfferDetail;
extern NSString *const kURLPromotionList;
extern NSString *const kURLPromotionDetail;

//Controllers' URL calls
extern NSString *const kURLOfferListCall;
extern NSString *const kURLOfferDetailCall;
extern NSString *const kURLPromotionListCall;
extern NSString *const kURLPromotionDetailCall;

// Endpoint URLs
extern NSString *const kURLOfferListEndpoint;
extern NSString *const kURLOfferDetailEndpoint;
extern NSString *const kPromotionListEndpoint;
extern NSString *const kURLPromotionDetailEndPoint;
