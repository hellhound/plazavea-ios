#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"

// Offer model's constants

// JSON keys
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

// JSON keys
NSString *const kOfferCollectionOffersKey = @"offers";
NSString *const kOfferCollectionBannerKey = @"banner";

// Banner model's constants

// JSON keys
NSString *const kBannerPictureURLKey = @"picture";
NSString *const kBannerStartKey = @"start";
NSString *const kBannerEndKey = @"end";

// Promotion model's constants

// JSON keys
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

// JSON keys
NSString *const kPromotionCollectionPromotions = @"promotions";

// OfferListDataSource's constants
NSString *const kOfferListTitleForLoading = @"Obteniendo ofertas";
//NSLocalizedString(@"Obteniendo ofertas", nil)
NSString *const kOfferListTitleForReloading = @"Actualizando ofertas";
//NSLocalizedString(@"Actualizando ofertas", nil)
NSString *const kOfferListTitleForEmpty = @"No hay ofertas";
//NSLocalizedString(@"No hay ofertas", nil)
NSString *const kOfferListSubtitleForEmpty = @"Por favor intente de nuevo más "
        @"tarde, aún no existen ofertas disponible";
//NSLocalizedString(@"Por favor intente de nuevo más "
//      @"tarde, aún no existen ofertas disponible", nil)
NSString *const kOfferListTitleForError = @"Error";
//NSLocalizedString(@"Error", nil)
NSString *const kOfferListSubtitleForError = @"Error";
//NSLocalizedString(@"Error", nil)
NSString *const kOfferListDefaultImage = @"bundle://default-list.png";

// PromotionListDataSource's constants

// Messages
NSString *const kPromotionListTitleForLoading = @"Obteniendo promociones";
// NSLocalizedString(@"Obteniendo promociones", nil)
NSString *const kPromotionListTitleForReloading = @"Actualizando promociones";
// NSLocalizedString(@"Actualizando promociones", nil)
NSString *const kPromotionListTitleForEmpty = @"No hay promociones";
// NSLocalizedString(@"No hay promociones", nil)
NSString *const kPromotionListSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existen promociones disponibles";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existen "
//      @"promociones disponibles", nil)
NSString *const kPromotionListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kPromotionListSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)

//UISegmentedControl item's label for the toolbar: promo button
NSString *const kOfferPromotionButtonLabel = @"Promociones";
//NSLocalizedString(@"Promociones", nil)
//UISegmentedControl item's label for the toolbar: offers button
NSString *const kOfferButtonLabel = @"Ofertas";
//NSLocalizedString(@"Ofertas", nil)

// PromotionListController's constants

NSString *const kPromotionListTitle = @"Promociones";
// NSLocalizedString(@"Promociones", nil)
       
// OfferListController's constants

NSString *const kOfferListTitle = @"Ofertas";
// NSLocalizedString(@"Ofertas", nil)
NSString *const kBannerDefaultImage = @"tt://bundle/default-banner.png";
const CGFloat kBannerImageWidth = 320.;
const CGFloat kBannerImageHeight = 100.;

//Controllers' URL
NSString *const kURLOfferList = @"tt://launcher/offers/offers/";
NSString *const kURLPromotionList = @"tt://launcher/offers/";

//Controllers' URL calls
NSString *const kURLOfferListCall = @"tt://launcher/offers/offers/";
NSString *const kURLPromotionListCall = @"tt://launcher/offers/";

// Endpoint URLs
NSString *const kURLOfferListEndpoint = ENDPOINT(@"/offers/listing.json");
NSString *const kPromotionListEndpoint = ENDPOINT(@"/promotions/listing.json");
