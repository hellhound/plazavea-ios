#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Wines/Constants.h"

// Wine model's constants

// JSON keys
NSString *const kWineIdKey = @"id";
NSString *const kWineCodeKey = @"code";
NSString *const kWineNameKey = @"name";
NSString *const kWineMillilitersKey = @"milliliters";
NSString *const kWineCountryKey = @"country";
NSString *const kWineRegionKey = @"region";
NSString *const kWineBrandKey = @"brand";
NSString *const kWineKindKey = @"kind";
NSString *const kWineWineryKey = @"winery";
NSString *const kWinePictureURLKey = @"picture";
NSString *const kWineExtraPicturesKey = @"extra_pictures";
NSString *const kWinePriceKey = @"price";
NSString *const kWineHarvestYearKey = @"harvest_year";
NSString *const kWineBarrelKey = @"barrel";
NSString *const kWineLookKey = @"look";
NSString *const kWineTasteKey = @"taste";
NSString *const kWineSmellKey = @"smell";
NSString *const kWineTemperatureKey = @"temperature";
NSString *const kWineCellaringKey = @"cellaring";
NSString *const kWineOxygenationKey = @"oxygenation";

// WineCollection's constants

// JSON keys
NSString *const kWineCollectionLetterKey = @"letter";
NSString *const kWineCollectionWinesKey = @"wines";

// Strain model's constants

// JSON keys
NSString *const kStrainIdKey = @"id";
NSString *const kStrainNameKey = @"name";
NSString *const kStrainSubcategories = @"subcategories";
NSString *const kStrainWines = @"wines";

// StrainCollection's constants

// JSON keys
NSString *const kStrainCollectionCategoriesKey = @"categories";

// StrainListDataSource's constants

// Messages
NSString *const kStrainListTitleForLoading = @"Obteniendo la lista";
// NSLocalizedString(@"Obteniendo la lista", nil)
NSString *const kStrainListTitleForReloading = @"Actualizando la lista";
// NSLocalizedString(@"Actualizando la lista", nil)
NSString *const kStrainListTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kStrainListSubtitleForEmpty = @"Por favor intente de nuevo "
@"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kStrainListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kStrainListSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)

// StrainListController's constants

// Messages
NSString *const kStrainListTitle = @"Cepas";
// NSLocalizedString(@""Cepas", nil) 

// WineListDataSource's constants

// Messages
NSString *const kWineListTitleForLoading = @"Obteniendo la lista";
// NSLocalizedString(@"Obteniendo la lista", nil)
NSString *const kWineListTitleForReloading = @"Actualizando la lista";
// NSLocalizedString(@"Actualizando la lista", nil)
NSString *const kWineListTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kWineListSubtitleForEmpty = @"Por favor intente de nuevo "
@"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kWineListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kWineListSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)

// WineListController's constants

// Messages
NSString *const kWineListTitle = @"Vinos";
// NSLocalizedString(@""Vinos", nil) 

// WineDetailDataSource's constants

// Messages
NSString *const kWineDetailTitleForLoading = @"Obteniendo datos";
// NSLocalizedString(@"Obteniendo datos", nil)
NSString *const kWineDetailTitleForReloading = @"Actualizando datos";
// NSLocalizedString(@"Actualizando datos", nil)
NSString *const kWineDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"@"Sin información", nil)
NSString *const kWineDetailSubtitleForEmpty = @"Por favor intente de nuevo "
@"más tarde, aún no existe información disponible";
// NSLocalizedString(@"Por favor intente de nuevo "
//      @"más tarde, aún no existe información disponible", nil)
NSString *const kWineDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kWineDetailSubtitleForError = @"Error";
// NSLocalizedString(@""Error", nil)

// messages
NSString *const kSomelierTitle = @"Somelier";
// NSLocalizedString(@""Somelier", nil) 

// Controllers' URLs
NSString *const kURLStrainList = @"tt://launcher/wines/strains/";
NSString *const kURLWineList =
        @"tt://launcher/wines/alphapetic/(initWithCategoryId:)/";

// Controllers' URL calls
NSString *const kURLStrainListCall = @"tt://launcher/wines/strains/";
NSString *const kURLWineListCall = @"tt://launcher/wines/alphapetic/%@/";

// Endpoint URLs
NSString *const kURLWineDetailEndPoint = ENDPOINT(@"/wines/%@/details.json");
NSString *const kURLWineCollectionEndPoint =
        ENDPOINT(@"/wines/%@/alphabetic.json");
NSString *const kURLStrainCollectionEndPoint =
        ENDPOINT(@"/wines/categories.json");