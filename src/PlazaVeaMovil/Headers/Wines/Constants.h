// Wine module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Wine model's constants

// JSON keys
extern NSString *const kWineIdKey;
extern NSString *const kWineCodeKey;
extern NSString *const kWineNameKey;
extern NSString *const kWineMillilitersKey;
extern NSString *const kWineCountryKey;
extern NSString *const kWineRegionKey;
extern NSString *const kWineBrandKey;
extern NSString *const kWineKindKey;
extern NSString *const kWineWineryKey;
extern NSString *const kWinePictureURLKey;
extern NSString *const kWineExtraPicturesKey;
extern NSString *const kWinePriceKey;
extern NSString *const kWineHarvestYearKey;
extern NSString *const kWineBarrelKey;
extern NSString *const kWineLookKey;
extern NSString *const kWineTasteKey;
extern NSString *const kWineSmellKey;
extern NSString *const kWineTemperatureKey;
extern NSString *const kWineCellaringKey;
extern NSString *const kWineOxygenationKey;

// WineCollection's constants

// JSON keys
extern NSString *const kWineCollectionLetterKey;
extern NSString *const kWineCollectionWinesKey;

// Strain model's constants

// JSON keys
extern NSString *const kStrainIdKey;
extern NSString *const kStrainNameKey;
extern NSString *const kStrainSubcategories;
extern NSString *const kStrainWines;

// StrainCollection model's constants

// JSON keys
extern NSString *const kStrainCollectionCategoriesKey;

// FilterCollection's constants

// JSON keys
extern NSString *const kFilterCollectionItemsKey;

// StrainListDataSource's constants

// Messages
extern NSString *const kStrainListTitleForLoading;
extern NSString *const kStrainListTitleForReloading;
extern NSString *const kStrainListTitleForEmpty;
extern NSString *const kStrainListSubtitleForEmpty;
extern NSString *const kStrainListTitleForError;
extern NSString *const kStrainListSubtitleForError;

// StrainListController's constants

//messages
extern NSString *const kStrainListTitle;

// WineListDataSource's constants

// Messages
extern NSString *const kWineListTitleForLoading;
extern NSString *const kWineListTitleForReloading;
extern NSString *const kWineListTitleForEmpty;
extern NSString *const kWineListSubtitleForEmpty;
extern NSString *const kWineListTitleForError;
extern NSString *const kWineListSubtitleForError;

// FilteringListDataSource's constants

// Messages
extern NSString *const kFilteringListTitleForLoading;
extern NSString *const kFilteringListTitleForReloading;
extern NSString *const kFilteringListTitleForEmpty;
extern NSString *const kFilteringListSubtitleForEmpty;
extern NSString *const kFilteringListTitleForError;
extern NSString *const kFilteringListSubtitleForError;

// WineListController's constants

// Messages
extern NSString *const kWineListTitle;

// WineDetailDataSource's constants

// Messages
extern NSString *const kWineDetailTitleForLoading;
extern NSString *const kWineDetailTitleForReloading;
extern NSString *const kWineDetailTitleForEmpty;
extern NSString *const kWineDetailSubtitleForEmpty;
extern NSString *const kWineDetailTitleForError;
extern NSString *const kWineDetailSubtitleForError;
extern NSString *const kWineMillilitersLabel;
extern NSString *const kWineCountryLabel;
extern NSString *const kWineRegionLabel;
extern NSString *const kWineBrandLabel;
extern NSString *const kWineKindLabel;
extern NSString *const kWineWineryLabel;
extern NSString *const kWinePriceLabel;
extern NSString *const kWineHarvestYearLabel;
extern NSString *const kWineBarrelLabel;
extern NSString *const kWineLookLabel;
extern NSString *const kWineTasteLabel;
extern NSString *const kWineSmellLabel;
extern NSString *const kWineTemperatureLabel;
extern NSString *const kWineCellaringLabel;
extern NSString *const kWineOxygenationLabel;
extern NSString *const kWineInfoLabel;
extern NSString *const kWineTastingLabel;
extern NSString *const kWineTipsLabel;
extern NSString *const kWineMarriageLabel;
extern NSString *const kWinePriceUnits;
extern NSString *const kWineTemperatureUnits;
extern NSString *const kWineCellaringUnits;
extern NSString *const kWineOxygenationUnits;
extern NSString *const kWineRecommendedLabel;

// WineFilterController's constants
typedef enum {
    kWineFilterSection,
    kWineGoSection
} WineFilterSectionType;

typedef enum {
    kWineCountryRow,
    kWineCategoryRow,
    kWineStrainRow,
    kWinePriceRow,
    kWineWineryRow
} WineFilterRowType;

typedef enum {
    kWineGoRow
} WineGoRowType;

extern NSString *const cellId;
extern NSString *const kWineUndefinedLabel;
extern NSString *const kWineCategoryLabel;
extern NSString *const kWineStrainLabel;
extern NSString *const kWineGoLabel;
extern const CGFloat kWineColor;

// FilteringListController's constants
typedef enum {
    kWineCountryFilter,
    kWineWineryFilter,
    kWineCategoryFilter,
    kWineStrainFilter
} WineFilteringListType;

extern NSString *const kWineCountriesLabel;
extern NSString *const kWineWineriesLabel;
extern NSString *const kWineStrainsLabel;
extern NSString *const kWineSparklingTypeLabel;

//LocalFilteringListController's constants
typedef enum {
    kWineCategoryLocalFilter,
    kWineWinesLocalFilter,
    kWinePriceLocalFilter
} WineLocalFilteringListType;

NSString *const kWineCategoriesLabel;
NSString *const kWineWinesLabel;
NSString *const kWinePricesLabel;
NSString *const kWineWineLabel;
NSString *const kWineSparklingLabel;
NSString *const kWineWhiteLabel;
NSString *const kWineRoseLabel;
NSString *const kWineRedLabel;
NSString *const kWineAllLabel;
NSString *const kWineLessThanLabel;
NSString *const kWineBetweenLabel;
NSString *const kWineMoreThanLabel;

// Generic sizes and images
extern const CGFloat kWineDetailImageWidth;
extern const CGFloat kWineDetailImageHeight;
extern const CGFloat kWineDetailLabelWidth;
extern NSString *const kWineDetailDefaultImage;
extern NSString *const kWineBannerImage;
extern NSString *const kWineBackgroundImage;

// Launcher
extern NSString *const kSomelierTitle;

// Controllers' URLs
extern NSString *const kURLWineFilter;
extern NSString *const kURLStrainList;
extern NSString *const kURLWineList;
extern NSString *const kURLWineDetail;
extern NSString *const kURLWineInfo;
extern NSString *const kURLWineTaste;
extern NSString *const kURLWineTips;
extern NSString *const kURLWineRecipe;
extern NSString *const kURLFiltering;

// Controllers' URL calls
extern NSString *const kURLWineFilterCall;
extern NSString *const kURLStrainListCall;
extern NSString *const kURLWineListCall;
extern NSString *const kURLWineDetailCall;
extern NSString *const kURLWineInfoCall;
extern NSString *const kURLWineTasteCall;
extern NSString *const kURLWineTipsCall;
extern NSString *const kURLWineRecipeCall;
extern NSString *const kURLFilteringCall;

// Endpoint URLs
extern NSString *const kURLWineDetailEndPoint;
extern NSString *const kURLWineCollectionEndPoint;
extern NSString *const kURLStrainCollectionEndPoint;
extern NSString *const kURLRecipeStrainCollectionEndPoint;
extern NSString *const kURLFilterCollectionEndPoint;
extern NSString *const kURLCountriesCollectionEndPoint;
extern NSString *const kURLWineriesCollectionEndPoint;
extern NSString *const kURLStrainsCollectionEndPoint;