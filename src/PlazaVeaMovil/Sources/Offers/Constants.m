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
NSString *const kOfferCollectionOffersKey = @"offers";
NSString *const kOfferCollectionBannerKey = @"banner";

// Banner model's constants
NSString *const kBannerPictureURLKey = @"picture";
NSString *const kBannerStartKey = @"start";
NSString *const kBannerEndKey = @"end";

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

// Offer collection's constants

//UISegmentedControl's item for the toolbar: promo button
NSString *const kOfferPromoButton = @"Promociones";
//NSLocalizedString(@"Promociones", nil)
//UISegmentedControl's item for the toolbar: offers button
NSString *const kOfferOfferButton = @"Ofertas";
//NSLocalizedString(@"Ofertas", nil)

// OfferListController's constants
NSString *const kOfferListTitle = @"Ofertas";
NSString *const kBannerDefaultImage = @"tt://bundle/default-banner.png";
const CGFloat kBannerImageWidth = 320.;
const CGFloat kBannerImageHeight = 100.;

//Controllers' URL
NSString *const kURLOfferList = @"tt://launcher/offers/offers";

//Controllers' URL calls
NSString *const kURLOfferListCall = @"tt://launcher/offers/offers";

// Endpoint URLs

NSString *const kURLOfferListEndpoint = ENDPOINT(@"/offers/listing.json");