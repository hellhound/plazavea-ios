#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"

// Offer model's constants
NSString *const kOfferIdKey = @"id";
NSString *const kOfferCodeKey = @"code";
NSString *const kOfferNameKey = @"name";
NSString *const kOfferDescriptionKey = @"description";
NSString *const kOfferPriceKey = @"price";
NSString *const kOfferOldPriceKey = @"old_price";
NSString *const kOfferDiscountKey = @"discount";
NSString *const kOfferValidFromKey = @"valid_from";
NSString *const kOfferValidToKey = @"valid_to";
NSString *const kOfferPictureURLKey = @"picture";
NSString *const kOfferExtraPictureURLsKey = @"extra_pictures";
NSString *const kOfferFacebookURLKey = @"facebook_url";
NSString *const kOfferTwitterURLKey = @"twitter_url";

// Offer collection model's constants
NSString *const kOfferCollectionPictureURLKey = @"picture";
NSString *const kOfferCollectionStartKey = @"start";
NSString *const kOfferCollectionEndKey = @"end";

// Banner model's constants
NSString *const kBannerPictureURLKey = @"picture";
NSString *const kBannerStartKey = @"start";
NSString *const kBannerEndKey = @"end";

// Offer collection's constants

//UISegmentedControl's item for the toolbar: promo button
NSString *const kOfferPromoButton = @"Promociones";
//NSLocalizedString(@"Promociones", nil)
//UISegmentedControl's item for the toolbar: offers button
NSString *const kOfferOfferButton = @"Ofertas";
//NSLocalizedString(@"Ofertas", nil)

//Controllers' URL
NSString *const kURLOfferList = @"tt://launcher/offers/offers";

//Controllers' URL calls
NSString *const kURLOfferListCall = @"tt://launcher/offers/offers";

// Endpoint URLs

NSString *const kURLOfferListEndpoint = ENDPOINT(@"/offers/listing.json");

