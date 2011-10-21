#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Stores/Constants.h"

// Region model's constants

//JSON keys
NSString *const kRegionIdKey = @"id";
NSString *const kRegionNameKey = @"name";

// Region Collection model's constants

//JSON keys
NSString *const kRegionCollectionRegionsKey = @"regions";

// SubregionCollection model's constants

// JSON keys
NSString *const kSubregionCollectionRegionsKey = @"subregions";

// RegionListDataSource's constants

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

// Controllers' URLs
NSString *const kURLRegionList = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionList =
        @"tt://launcher/stores/regions/subregions/(initWithRegionId:)/";
NSString *const kURLStoreList =
        @"tt://launcher/stores/subregions/(initWithSubregionId:)/";

// Controllers' URL calls
NSString *const kURLRegionListCall = @"tt://launcher/stores/regions/";
NSString *const kURLSubregionListCall =
        @"tt://launcher/stores/regions/subregions/%@/";
NSString *const kURLStoreListCall =
        @"tt://launcher/stores/subregions/%@/";

// Endpoint URLs
NSString *const kRegionListEndPoint = ENDPOINT(@"/regions/listing.json");
NSString *const kSubregionListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/listing.json/");
NSString *const kStoreListEndPoint =
        ENDPOINT(@"/regions/%@/subregions/%@/stores/listing.json/");
