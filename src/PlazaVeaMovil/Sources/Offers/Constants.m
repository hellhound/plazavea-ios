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
