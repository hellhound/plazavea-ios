#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Stores/Constants.h"

// Region model's constants

//JSON keys
NSString *const kRegionIdKey = @"id";
NSString *const kRegionNameKey = @"name";
NSString *const kRegionCountKey = @"count";
NSString *const kRegionSuggestedKey = @"suggested";

// Region Collection model's constants

//JSON keys
NSString *const kRegionCollectionRegionsKey = @"regions";

// SubregionCollection model's constants

// JSON keys
NSString *const kSubregionCollectionRegionsKey = @"subregions";

// Service model's constants's

// JSON keys
NSString *const kServiceIdKey = @"id";
NSString *const kServiceNameKey = @"name";
NSString *const kServiceURLKey = @"url";

// Store model's constants's

// JSON keys
NSString *const kStoreIdKey = @"id";
NSString *const kStoreNameKey = @"name";
NSString *const kStoreAdressKey = @"address";
NSString *const kStorePictureURLKey = @"picture";
NSString *const kStoreLatitudeKey = @"latitude";
NSString *const kStoreLongitudeKey = @"longitude";
NSString *const kStoreCodeKey = @"code";
NSString *const kStoreAttendanceKey = @"attendance";
NSString *const kStoreLocationKey = @"location";
NSString *const kStoreRegionKey = @"region";
NSString *const kStoreSubregionKey = @"subregion";
NSString *const kStoreDisctrictKey = @"district";
NSString *const kStoreUbigeoKey = @"ubigeo";
NSString *const kStorePhonesKey = @"phones";
NSString *const kStoreServicesKey = @"services";

// StoreCollection's constants

// JSON keys
NSString *const kStoreCollectionDistrictsKey = @"districts";
NSString *const kStoreCollectionNameKey = @"name";
NSString *const kStoreCollectionIdKey = @"id";
NSString *const kStoreCollectionStoresKey = @"stores";

// RegionListDataSource's constants

// Generic sizes and images
const CGFloat kStoreDetailImageWidth = 320.;
const CGFloat kStoreDetailImageHeight = 140.;
const CGFloat kStoreDetailLabelWidth = 320.;
NSString *const kStoreDetailDefaultImage =
        @"bundle://default-store-detail.png";
const CGFloat kRegionListImageWidth = 320.;
const CGFloat kRegionListImageHeight = 140.;
NSString *const kRegionListDefaultImage =
        @"bundle://default-banner-stores.jpg";

// Messages
NSString *const kRegionListTitleForLoading = @"Obteniendo la lista";
// NSLocalizedString(@"Obteniendo la lista", nil)
NSString *const kRegionListTitleForReloading = @"Actualizando la lista";
// NSLocalizedString(@"Actualizando la lista", nil)
NSString *const kRegionListTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kRegionListSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kRegionListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kRegionListSubtitleForError = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)

// StoreListDataSource's constants

// Messages
NSString *const kStoreListTitleForLoading = @"Obteniendo la lista";
// NSLocalizedString(@"Obteniendo la lista", nil)
NSString *const kStoreListTitleForReloading = @"Actualizando la lista";
// NSLocalizedString(@"Actualizando la lista", nil)
NSString *const kStoreListTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kStoreListSubtitleForEmpty = @"Por favor intente de nuevo "
@"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kStoreListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kStoreListSubtitleForError = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)

// StoreDetailDataSource's constants

// Messages
NSString *const kStoreDetailTitleForLoading = @"Obteniendo datos";
// NSLocalizedString(@"Obteniendo datos", nil)
NSString *const kStoreDetailTitleForReloading = @"Actualizando datos";
// NSLocalizedString(@"Actualizando datos", nil)
NSString *const kStoreDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kStoreDetailSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kStoreDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kStoreDetailSubtitleForError = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kStoreDetailData = @"Datos";
// NSLocalizedString(@"Datos", nil)
NSString *const kStoreDetailServices = @"Servicios";
// NSLocalizedString(@"Servicios", nil)
NSString *const kStoreDetailAddress = @"Dirección: %@";
// NSLocalizedString(@"Dirección: %@")
NSString *const kStoreDetailDistrict = @"Distrito: %@";
// NSLocalizedString(@"Distrito: %@")
NSString *const kStoreDetailAttendance = @"Horario: %@";
// NSLocalizedString(@"Horario: %@")
NSString *const kStoreDetailPhones = @"Teléfonos: %@";
// NSLocalizedString(@"Teléfonos: %@")

// RegionListController's constants

// Messages
NSString *const kRegionListTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)
NSString *const kSubregionListTitle = @"Provincias";
// NSLocalizedString(@"Provincias", nil)
NSString *const kRegionLauncherTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)
NSString *const kSubregionListName = @"Provincias de %@";
// NSLocalizedString(@"Provincias de %@", nil)

// StoreListController's constants

// Messages
NSString *const kStoreListTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)
NSString *const kStoreListButtonLabel = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)
NSString *const kStoreMapButtonLabel = @"Mapa";
// NSLocalizedString(@"Mapa", nil)
NSString *const kStoreDetailButtonLabel = @"Detalles";
// NSLocalizedString(@"Detalles", nil)

// StoreMapController's constants
NSString *const kStoreMapTitle = @"Mapa";
// NSLocalizedString(@"Mapa", nil)
NSString *const kStoreMapGPSButton = @"bullseye.png";
NSString *const kStoreMapOptionButton = @"pagecurl.png";
NSString *const kStoreMapCurrentLocation = @"Ubicación actual";
// NSLocalizedString(@"Ubicación actual", nil)
NSString *const kStoreMapAnnotationImage = @"annotation-pin.png";
const float minRegion = 500.;
NSString *const kAnnotationId = @"AnnotationView";
NSString *const kPinAnnotationId = @"PinAnnotationView";
const CGFloat kStoreMapImageWidth = 32.;
const CGFloat kStoreMapImageHeight = 32.;
NSString *const kStoreMapTypeStandard = @"Estándar";
// NSLocalizedString(@"Estándar", nil)
NSString *const kStoreMapTypeSatellite = @"Satélite";
// NSLocalizedString(@"Satélite", nil)
NSString *const kStoreMapTypeHybrid = @"Híbrido";
// NSLocalizedString(@"Híbrido", nil)
NSString *const kStoreMapTypeLabel = @"Seleccione el tipo de mapa:";
// NSLocalizedString(@"Seleccione el tipo de mapa:", nil)

// StoreMapController's constants
const CGFloat kStoreDetailBackground = 0.85;

// Controllers' URLs
NSString *const kURLRegionList = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionList =
        @"tt://launcher/stores/regions/subregions/(initWithRegionId:)/(name:)/";
NSString *const kURLStoreList = @"tt://launcher/stores/stores/" \
        "(initWithSubregionId:)/(andRegionId:)/(name:)/";
NSString *const kURLStoreDetail = @"tt://launcher/store/(initWithStoreId:)/";
NSString *const kURLStoreMap = @"tt://launcher/stores/map/"
        @"(initWithSubregionId:)/(andRegionId:)/(andTitle:)";
NSString *const kURLStoreDetailMap =
        @"tt://launcher/store/map/(initWithStoreId:)/(andTitle:)";

// Controllers' URL calls
NSString *const kURLRegionListCall = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionListCall =
        @"tt://launcher/stores/regions/subregions/%@/%@/";
NSString *const kURLStoreListCall =
        @"tt://launcher/stores/stores/%@/%@/%@/";
NSString *const kURLStoreDetailCall = @"tt://launcher/store/%@/";
NSString *const kURLStoreMapCall = @"tt://launcher/stores/map/%@/%@/%@/";
NSString *const kURLStoreDetailMapCall = @"tt://launcher/store/map/%@/%@/";

// Endpoint URLs
NSString *const kRegionListEndPoint = ENDPOINT(@"/regions/listing.json");
NSString *const kSubregionListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/listing.json");
NSString *const kStoreListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/%@/stores/listing.json");
NSString *const kStoreDetailEndPoint = ENDPOINT(@"/stores/%@/details.json");
