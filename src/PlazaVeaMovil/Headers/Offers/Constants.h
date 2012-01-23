//Offers module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Offer model's constants

// JSON keys
extern NSString *const kOfferIdKey;
extern NSString *const kOfferCodeKey;
extern NSString *const kOfferNameKey;
extern NSString *const kOfferDescriptionKey;
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
extern NSString *const kOfferDetailOldPriceLabel;
extern NSString *const kOfferDetailPriceLabel;
extern NSString *const kOfferDetailValidLabel;
extern NSString *const kOfferDetailPriceSufix;
extern NSString *const kOfferDetailValidSufix;

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
extern const CGFloat kOfferDetailImageWidth;
extern const CGFloat kOfferDetailImageHeight;
extern NSString *const kOfferDetailDefaultImage;

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
