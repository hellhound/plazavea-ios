#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

// PromotionListDataSource's constants

// Messages
extern NSString *const kPromotionListTitleForLoading;
extern NSString *const kPromotionListTitleForReloading;
extern NSString *const kPromotionListTitleForEmpty;
extern NSString *const kPromotionListSubtitleForEmpty;
extern NSString *const kPromotionListTitleForError;
extern NSString *const kPromotionListSubtitleForError;


// OfferDrillDownController's constants

typedef enum {
    kOfferSegmentedControlIndexPromoButton,
    kOfferSegmentedControlIndexOfferButton,
    kOfferSegmentedControlIndexDefault =
        kOfferSegmentedControlIndexOfferButton
}OfferSegmentedControlIndexTypes;

//UISegmentedControl's item for the toolbar: promo button
extern NSString *const kOfferPromoButton;
//UISegmentedControl's item for the toolbar: offers button
extern NSString *const kOfferOfferButton;

//Controllers' URL

//Controllers' URL calls

// Endpoint URLs
extern NSString *const kPromotionListEndpoint;
