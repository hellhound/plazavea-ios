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
NSString *const kRegionCollectionRegions = @"regions";

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
NSString *const kRegionListTitle = @"Departamentos";
// NSLocalizedString(@"Departamentos", nil)

// Endpoint URLs
NSString *const kRegionListEndPoint = ENDPOINT(@"/regions/listing.json");