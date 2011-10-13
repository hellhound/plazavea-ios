#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"

// Promotion model's constants
NSString *const kPromotionIdKey = @"id";
NSString *const kPromotionCodeKey = @"code";
NSString *const kPromotionNameKey = @"name";
NSString *const kPromotionBannerURLKey = @"picture";
NSString *const kPromotionDescriptionKey = @"description";
NSString *const kPromotionLegaleseKey = @"legalese";
NSString *const kPromotionValidFromKey = @"valid_from";
NSString *const kPromotionValidToKey = @"valid_to";
NSString *const kPromotionExtraPictureURLsKey = @"extra_pictures";
NSString *const kPromotionFacebookURLKey = @"facebook_url";
NSString *const kPromotionTwitterURLKey = @"twitter_url";

// Promition collection model's constants
NSString *const kPromotionCollectionPromotions = @"promotions";

//UISegmentedControl's item for the toolbar: promo button
NSString *const kOfferPromoButton = @"Promociones";
//NSLocalizedString(@"Promociones", nil)
//UISegmentedControl's item for the toolbar: offers button
NSString *const kOfferOfferButton = @"Ofertas";
//NSLocalizedString(@"Ofertas", nil)

//Controllers' URL

//Controllers' URL calls

// Endpoint URLs
NSString *const kPromotionListEndpoint = ENDPOINT(@"/promotions/listing.json");
