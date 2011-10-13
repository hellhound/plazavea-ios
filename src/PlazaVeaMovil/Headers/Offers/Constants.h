//Offers module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Offer model's constants
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
extern NSString *const kOfferCollectionOffersKey;
extern NSString *const kOfferCollectionBannerKey;

// Banner model's constant
extern NSString *const kBannerPictureURLKey;
extern NSString *const kBannerStartKey;
extern NSString *const kBannerEndKey;

// OfferListDataSource's constants
extern NSString *const kOfferListTitleForLoading;
extern NSString *const kOfferListTitleForReloading;
extern NSString *const kOfferListTitleForEmpty;
extern NSString *const kOfferListSubtitleForEmpty;
extern NSString *const kOfferListTitleForError;
extern NSString *const kOfferListSubtitleForError;
extern NSString *const kOfferListDefaultImage;

// Offer collection's constants

// OfferDrillDownController's constants

typedef enum {
    kOfferSegmentedControlIndexPromoButton,
    kOfferSegmentedControlIndexOfferButton,
    kOfferSegmentedControlIndexDefault =
        kOfferSegmentedControlIndexOfferButton
}OfferSegmentedControlIndexTypes;

// UISegmentedControl item for the toolbar: promo button
extern NSString *const kOfferPromoButton;
// UISegmentedControl item for the toolbar: offer button
extern NSString *const kOfferOfferButton;

// OfferListController's constants
extern NSString *const kOfferListTitle;
extern NSString *const kBannerDefaultImage;
extern const CGFloat kBannerImageWidth;
extern const CGFloat kBannerImageHeight;

// Controllers' URL
extern NSString *const kURLOfferList;

extern NSString *const kURLOfferListCall;

// Endpoint URLs

extern NSString *const kURLOfferListEndpoint;

