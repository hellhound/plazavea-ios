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
NSString *const kWineMillilitersLabel = @"Mililitros";
// NSLocalizedString(@"Mililitros", nil)
NSString *const kWineCountryLabel = @"País";
// NSLocalizedString(@"País", nil)
NSString *const kWineRegionLabel = @"Región";
// NSLocalizedString(@"Región", nil)
NSString *const kWineBrandLabel = @"Marca";
// NSLocalizedString(@"Marca", nil)
NSString *const kWineKindLabel = @"Tipo";
// NSLocalizedString(@"Tipo", nil)
NSString *const kWineWineryLabel = @"Bodega";
// NSLocalizedString(@"Bodega, nil)
NSString *const kWinePriceLabel = @"Precio";
// NSLocalizedString(@"Precio", nil)
NSString *const kWineHarvestYearLabel = @"Fecha de Vendimia";
// NSLocalizedString(@"Fecha de vendimia", nil)
NSString *const kWineBarrelLabel = @"Barrica";
// NSLocalizedString(@"Barrica, nil)
NSString *const kWineLookLabel = @"Vista";
// NSLocalizedString(@"Vista", nil)
NSString *const kWineTasteLabel = @"Gusto";
// NSLocalizedString(@"Gusto", nil)
NSString *const kWineSmellLabel = @"Nariz";
// NSLocalizedString(@"Nariz", nil)
NSString *const kWineTemperatureLabel = @"Temperatura";
// NSLocalizedString(@"Temperatura", nil)
NSString *const kWineCellaringLabel = @"Potencia de Guarda";
// NSLocalizedString(@"Potencial de guarda", nil)
NSString *const kWineOxygenationLabel = @"Oxigenación";
// NSLocalizedString(@"Oxigenación", nil)
NSString *const kWineInfoLabel = @"Información";
// NSLocalizedString(@"Información", nil)
NSString *const kWineTastingLabel = @"Nota de cata";
// NSLocalizedString(@"Nota de cata", nil)
NSString *const kWineTipsLabel = @"Tips";
// NSLocalizedString(@"Tips", nil)
NSString *const kWineMarriageLabel = @"Maridaje";
// NSLocalizedString(@"Maridaje", nil)
NSString *const kWinePriceUnits = @"S/. %@";
// NSLocalizedString(@"S/. %@", nil)
NSString *const kWineTemperatureUnits = @"%@ ºC";
// NSLocalizedString(@"%@ ºC", nil)
NSString *const kWineCellaringUnits = @"%@ meses";
// NSLocalizedString(@"%@ meses", nil)
NSString *const kWineOxygenationUnits = @"%@ minutos";
// NSLocalizedString(@"%@ minutos", nil)
NSString *const kWineRecommendedLabel = @"Vinos Recomendados";
// NSLocalizedString(@"Vinos Recomendados", nil)

// Generic sizes and images
const CGFloat kWineDetailImageWidth = 320.;
const CGFloat kWineDetailImageHeight = 140.;
const CGFloat kWineDetailLabelWidth = 320.;
NSString *const kWineDetailDefaultImage = @"bundle://default-wine-detail.png";
NSString *const kWineBannerImage = @"bundle://sommelier-banner.jpg";
NSString *const kWineBackgroundImage = @"bundle://wine-background.png";

// Launcher
NSString *const kSomelierTitle = @"Sommelier";
// NSLocalizedString(@""Somelier", nil) 

// Controllers' URLs
NSString *const kURLStrainList = @"tt://launcher/wines/strains/";

NSString *const kURLWineList =
        @"tt://launcher/wines/alphapetic/(initWithCategoryId:)/";
NSString *const kURLWineDetail = @"tt://launcher/wines/wine/(initWithWineId:)/";
NSString *const kURLWineInfo =
        @"tt://launcher/wines/wine_info/(initWithWineId:)/";
NSString *const kURLWineTaste =
        @"tt://launcher/wines/wine_taste/(initWithWineId:)/";
NSString *const kURLWineTips =
        @"tt://launcher/wines/wine_tips/(initWithWineId:)/";
NSString *const kURLWineRecipe =
        @"tt://launcher/wines/wine_recipe/(initWithWineId:)/(name:)/";

// Controllers' URL calls
NSString *const kURLStrainListCall = @"tt://launcher/wines/strains/";
NSString *const kURLWineListCall = @"tt://launcher/wines/alphapetic/%@/";
NSString *const kURLWineDetailCall = @"tt://launcher/wines/wine/%@/";
NSString *const kURLWineInfoCall = @"tt://launcher/wines/wine_info/%@/";
NSString *const kURLWineTasteCall = @"tt://launcher/wines/wine_taste/%@/";
NSString *const kURLWineTipsCall = @"tt://launcher/wines/wine_tips/%@/";
NSString *const kURLWineRecipeCall = @"tt://launcher/wines/wine_recipe/%@/%@";

// Endpoint URLs
NSString *const kURLWineDetailEndPoint = ENDPOINT(@"/wines/%@/details.json");
NSString *const kURLWineCollectionEndPoint =
        ENDPOINT(@"/wines/%@/alphabetic.json");
NSString *const kURLStrainCollectionEndPoint =
        ENDPOINT(@"/wines/categories.json");
NSString *const kURLRecipeStrainCollectionEndPoint =
        ENDPOINT(@"/recipes/%@/wines/categories.json");