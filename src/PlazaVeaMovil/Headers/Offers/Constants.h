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
extern NSString *const kOfferCollectionPictureURLKey;
extern NSString *const kOfferCollectionStartKey;
extern NSString *const kOfferCollectionEndKey;

// Banner model's constant
extern NSString *const kBannerPictureURLKey;
extern NSString *const kBannerStartKey;
extern NSString *const kBannerEndKey;

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

// Controllers' URL
extern NSString *const kURLOfferList;

extern NSString *const kURLOfferListCall;

// Endpoint URLs

extern NSString *const kURLOfferListEndpoint;

