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
const CGFloat kStoreDetailImageHeight = 100.;
const CGFloat kStoreDetailLabelWidth = 320.;
NSString *const kStoreDetailDefaultImage =
        @"bundle://default-banner.png";

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
NSString *const kRegionListSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)

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
NSString *const kStoreListSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)

// StoreDetailDataSource's constants

// Messages
NSString *const kStoreDetailTitleForLoading = @"Obteniendo la lista";
// NSLocalizedString(@"Obteniendo la lista", nil)
NSString *const kStoreDetailTitleForReloading = @"Actualizando la lista";
// NSLocalizedString(@"Actualizando la lista", nil)
NSString *const kStoreDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kStoreDetailSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kStoreDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kStoreDetailSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)
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
NSString *const kRegionListTitle = @"Departamentos";
// NSLocalizedString(@"Departamentos", nil)
NSString *const kSubregionListTitle = @"Provincias";
// NSLocalizedString(@"Provincias", nil)
NSString *const kRegionLauncherTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)


// StoreListController's constants

// Messages
NSString *const kStoreListTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)
NSString *const kStoreListButtonLabel = @"Lista";
// NSLocalizedString(@"Lista", nil)
NSString *const kStoreMapButtonLabel = @"Mapa";
// NSLocalizedString(@"Mapa", nil)

// StoreMapController's constants
NSString *const kStoreMapTitle = @"Tiendas";
// NSLocalizedString(@"Tiendas", nil)

// Controllers' URLs
NSString *const kURLRegionList = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionList =
        @"tt://launcher/stores/regions/subregions/(initWithRegionId:)/";
NSString *const kURLStoreList =
        @"tt://launcher/stores/stores/(initWithSubregionId:)/(andRegionId:)/";
NSString *const kURLStoreDetail = @"tt://launcher/store/(initWithStoreId:)/";
NSString *const kURLStoreMap = @"tt://launcher/stores/map/";

// Controllers' URL calls
NSString *const kURLRegionListCall = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionListCall =
        @"tt://launcher/stores/regions/subregions/%@/";
NSString *const kURLStoreListCall =
        @"tt://launcher/stores/stores/%@/%@";
NSString *const kURLStoreDetailCall = @"tt://launcher/store/%@/";
NSString *const kURLStoreMapCall = @"tt://launcher/stores/map/";

// Endpoint URLs
NSString *const kRegionListEndPoint = ENDPOINT(@"/regions/listing.json/");
NSString *const kSubregionListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/listing.json/");
NSString *const kStoreListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/%@/stores/listing.json/");
NSString *const kStoreDetailEndPoint = ENDPOINT(@"/stores/%@/details.json/");
