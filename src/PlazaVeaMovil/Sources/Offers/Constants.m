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
NSString *const kOfferLegaleseKey = @"legalese";
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
NSString *const kBannerIdKey = @"id";
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

// Messages
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
NSString *const kOfferListSubtitleForError = @"Por favor intente de nuevo más "
        @"tarde, aún no existen ofertas disponible";
//NSLocalizedString(@"Por favor intente de nuevo más "
//      @"tarde, aún no existen ofertas disponible", nil)

NSString *const kOfferListPriceTag = @" a S/.";
//NSLocalizedString(@" a S/.", nil)
NSString *const kOfferListDefaultImage = @"bundle://default-list.png";

// OfferDetailDataSource's constants

// Messages
NSString *const kOfferDetailTitleForLoading = @"Obteniendo la oferta";
//NSLocalizedString(@"Obteniendo la oferta", nil)
NSString *const kOfferDetailTitleForEmpty = @"Sin información";
//NSLocalizedString(@"Sin información", nil)
NSString *const kOfferDetailSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información para esta oferta";
//NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información para esta oferta", nil)
NSString *const kOfferDetailTitleForError = @"Error";
//NSLocalizedString(@"Error", nil)
NSString *const kOfferDetailSubtitleForError = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información para esta oferta";
//NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información para esta oferta", nil)
NSString *const kOfferDetailOldPriceCaption = @"Precio original";
//NSLocalizedString(@"Precio original", nil)
NSString *const kOfferDetailPriceCaption = @"Precio de la oferta";
//NSLocalizedString(@"Precio de la oferta", nil)
NSString *const kOfferDetailValidCaption = @"Vigencia";
//NSLocalizedString(@"Vigencia", nil)
NSString *const kOfferDetailPricePrefix = @"S/. %.2f";
//NSLocalizedString(@"S/. %.2f", nil)
NSString *const kOfferDetailValidPrefix = @"%@ al %@";
//NSLocalizedString(@"%@ al %@", nil)
NSString *const kOfferDetailLegaleseCaption = @"Legales";
//NSLocalizedString(@"Legales", nil)

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
NSString *const kPromotionListSubtitleForError = @"Por favor intente de nuevo "
        @"más tarde, aún no existen promociones disponibles";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existen "
//      @"promociones disponibles", nil)

const CGFloat kPromotionListImageWidth = 320.;
const CGFloat kPromotionListImageHeight = 140.;
NSString *const kPromotionListDefaultBanner = @"bundle://default-banner.png";
//UISegmentedControl item's label for the toolbar: promo button
NSString *const kOfferPromotionButtonLabel = @"Promociones";
//NSLocalizedString(@"Promociones", nil)
//UISegmentedControl item's label for the toolbar: offers button
NSString *const kOfferButtonLabel = @"Ofertas";
//NSLocalizedString(@"Ofertas", nil)

// PromotionDetailDataSource's constants

//Messages
NSString *const kPromotionDetailTitleForLoading = @"Obteniendo la promoción";
// NSLocalizedString(@"Obteniendo la promoción", nil)
NSString *const kPromotionDetailTitleForReloading =
        @"Actualizando la promoción";
// NSLocalizedString(@"Actualizando la promoción", nil)
NSString *const kPromotionDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"Sin información", nil)
NSString *const kPromotionDetailSubtitleForEmpty = @"Por favor intente de "
        @"nuevo más tarde, aún no existe información para esta oferta";
// NSLocalizedString(@"Por favor intente de "
//      @" nuevo más tarde, aún no existe información para esta oferta", nil)
NSString *const kPromotionDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kPromotionDetailSubtitleForError = @"Por favor intente de "
        @"nuevo más tarde, aún no existe información para esta oferta";
// NSLocalizedString(@"Por favor intente de "
//      @" nuevo más tarde, aún no existe información para esta oferta", nil)
NSString *const kPromotionDetailLegaleseCaption = @"Legales";
//NSLocalizedString(@"Legales", nil)

// PromotionListController's constants

NSString *const kPromotionListTitle = @"Promociones";
// NSLocalizedString(@"Promociones", nil)
       
// OfferListController's constants

// Messages
NSString *const kOfferListTitle = @"Ofertas";
// NSLocalizedString(@"Ofertas", nil)


// OfferDetailController's constants

// Messages
NSString *const kOfferDetailTitle = @"Detalle de oferta";
// NSLocalizedString(@"Detalle de oferta", nil)
const CGFloat kOfferDetailBackground = .85;
const CGFloat kOfferDetailImageWidth = 320.;
const CGFloat kOfferDetailImageHeight = 140.;
const CGFloat kOfferDetailLabelWidth = 320.;
NSString *const kOfferDetailDefaultImage =
        @"bundle://default-offer-detail.png";
NSString *const kOfferDetailShare = @"Compartir vía";
// NSLocalizedString(@"Compartir vía", nil)
NSString *const kOfferDetailMailImage = @"bundle://mail-icon.png";
NSString *const kOfferDetailFacebookImage = 
        @"bundle://facebook-icon.png";
NSString *const kOfferDetailTwitterImage = @"bundle://twitter-icon.png";

NSString *const kBannerDefaultImage =
        @"bundle://default-banner-offers-list.png";
NSString *const kOfferBannerDefaultImage =
        @"bundle://default-banner-offers.jpg";
const CGFloat kBannerImageWidth = 320.;
const CGFloat kBannerImageHeight = 140.;
const CGFloat kOfferListImageWidth = 50.;
const CGFloat kOfferListImageHeight = 50.;
NSString *const kTwitterAlertTitle = @"Enviar tweet";
// NSLocalizedString(@"Enviar tweet", nil)
NSString *const kTwitterAlertCancel = @"Cancelar";
// NSLocalizedString(@"Cancelar", nil)
NSString *const kTwitterAlertSend = @"Enviar";
// NSLocalizedString(@"Enviar", nil)
NSString *const kTwitterAlertMessage = @"%@ %@";
// NSLocalizedString(@"%@ %@", nil)
NSString *const kFBLink = @"link";
// NSLocalizedString(@"link", nil)
NSString *const kFBPicture = @"picture";
// NSLocalizedString(@"picture", nil)
NSString *const kFBCaption = @"caption";
// NSLocalizedString(@"caption", nil)
NSString *const kFBDescription = @"description";
// NSLocalizedString(@"description", nil)
NSString *const kFBFeedDialog = @"feed";
// NSLocalizedString(@"feed", nil)
NSString *const kMailBanner =
@"http://demos.bitzeppelin.com/spsa/assets/mailing/offers/plazavea-logo.jpg";
const CGFloat kMailBannerWidth = 300.;
const CGFloat kMailBannerHeight = 208.;
const CGFloat kMailImageHeight = 131.;
NSString *const kOfferMailSubject =
        @"Plaza Vea te envía la siguiente oferta: %@";
NSString *const kPromotionMailSubject =
        @"Plaza Vea te envía la siguiente promoción: %@";
NSString *const kDivTag = @"<div style=\"width:%.0fpx\">";
NSString *const kTitleTag = @"<p><h1 style=\"font-family:sans-serif;\
        font-size:16pt; text-align:center\">%@</h1></p>";
NSString *const kImageTag = @"<img src= \"%@?width=%.0f&height=%.0f\"\
        width=\"%.0f\" height=\"%.0f\" />";
NSString *const kOfferPriceTag = @"<p style=\"font-family:sans-serif;\
        font-size:12pt; text-align:center; color:red\">%@</p>";
NSString *const kOldPriceTag = @"<p style=\"font-family:sans-serif;\
        font-size:12pt; text-align:center\">%@</p>";
NSString *const kValidTag = @"<p style=\"font-family:sans-serif;\
        font-size:12pt; text-align:center\">%@</p>";
NSString *const kDescriptionTag = @"<p style=\"font-family:sans-serif;\
        font-size:12pt\">%@</p>";
NSString *const kLegaleseTag = @"<p style=\"font-family:sans-serif;\
        font-size:8pt\">%@</p>";
NSString *const kMailFooterTag = @"<p style=\"font-family:sans-serif;\
        font-size:13pt\">Encuentra más ofertas y promociones en Plaza Vea\
            Móvil. Ingresa aquí.</p>";


// PromotionDetailController's constants
NSString *const kPromotionDetailTitle = @"Detalle de la promoción";
// NSLocalizedString(@"Detalle de la promoción", nil)
const CGFloat kPromotionDetailImageWidth = 320.;
const CGFloat kPromotionDetailImageHeight = 140.;

//Controllers' URL
NSString *const kURLOfferList = @"tt://launcher/offers/offers/";
NSString *const kURLOfferDetail = @"tt://launcher/offer/(initWithOfferId:)/";
NSString *const kURLPromotionList = @"tt://launcher/offers/";
NSString *const kURLPromotionDetail =
        @"tt://launcher/offers/promotions/(initWithPromotionId:)/";

//Controllers' URL calls
NSString *const kURLOfferListCall = @"tt://launcher/offers/offers/";
NSString *const kURLOfferDetailCall = @"tt://launcher/offer/%@/";
NSString *const kURLPromotionListCall = @"tt://launcher/offers/";
NSString *const kURLPromotionDetailCall =
        @"tt://launcher/offers/promotions/%@/";

// Endpoint URLs
NSString *const kURLOfferListEndpoint = ENDPOINT(@"/offers/listing.json");
NSString *const kURLOfferDetailEndpoint = ENDPOINT(@"/offers/%@/details.json");
NSString *const kPromotionListEndpoint = ENDPOINT(@"/promotions/listing.json");
NSString *const kURLPromotionDetailEndPoint =
        ENDPOINT(@"/promotions/%@/details.json");

