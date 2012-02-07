#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct pickerIndex {
    NSInteger row;
    NSInteger component;
    
};
typedef struct pickerIndex pickerIndex;

typedef enum {
    kBodyMeterActivityUndefined,
    kBodyMeterActivityMinimal,
    kBodyMeterActivityLight,
    kBodyMeterActivityModerate,
    kBodyMeterActivityIntense
}kBodyMeterActivityType;

typedef enum {
    kBodyMeterGenderUndefined,
    kBodyMeterGenderMale,
    kBodyMeterGenderFemale
}kBodyMeterGenderType;

typedef enum {
    kBodyMeterProfileSection,
    kBodyMeterWeightSection
}kBodyMeterProfileSectionType;

typedef enum {
    kBodyMeterAgeRow,
    kBodyMeterGenderRow,
    kBodyMeterHeightRow,
    kBodyMeterWeightRow,
    kBodyMeterActivityRow
}kBodyMeterProfileRowType;

typedef enum {
    kBodyMeterIdealWeightRow
}kBodyMeterWeightRowType;

typedef enum {
    kBodyMeterDiagnosisSection,
    kBodyMeterGoalSection
}kBodyMeterDiagnosisSectionType;

typedef enum {
    kBodyMeterRangeRow,
    kBodyMeterCMIRow,
    kBodyMeterResultRow
}kBodyMeterDiagnosisRowType;

typedef enum {
    kBodyMeterCalorieComsuptionRow,
    kBodyMeterTimeRow,
    kBodyMeterEnergyConsumptionRow,
    kBodyMeterRecomendationsRow
}kBodyMeterGoalRowType;

// Diagnosis model constants
extern const float kDiagnosisThinnessIIIndex;
extern const float kDiagnosisThinnessIndex;
extern const float kDiagnosisNormalIndex;
extern const float kDiagnosisOverWeightIndex;
extern const float kDiagnosisObesityIndex;
extern const float kDiagnosisObesityIIIndex;

extern const float kDiagnosisMaleMBRConstant;
extern const float kDiagnosisMaleMBRWeightFactor;
extern const float kDiagnosisMaleMBRHeightFactor;
extern const float kDiagnosisMaleMBRAgeFactor;

extern const float kDiagnosisFemaleMBRConstant;
extern const float kDiagnosisFemaleMBRWeightFactor;
extern const float kDiagnosisFemaleMBRHeightFactor;
extern const float kDiagnosisFemaleMBRAgeFactor;

extern const float kDiagnosisMinimalActivityFactor;
extern const float kDiagnosisLightActivityFactor;
extern const float kDiagnosisModerateActivityFactor;
extern const float kDiagnosisIntenseActivityFactor;

extern const float kDiagnosisEnergyConstant;
extern const float kDiagnosisWeightGainFactor;
extern const float kDiagnosisWeightLossFactor;
extern const float kDiagnosisDaysOfMonth;

extern const float kDiagnosis1of5MealsFactor;
extern const float kDiagnosis2of5MealsFactor;
extern const float kDiagnosis3of5MealsFactor;
extern const float kDiagnosis4of5MealsFactor;
extern const float kDiagnosis5of5MealsFactor;

extern const float kDiagnosis1of3MealsFactor;
extern const float kDiagnosis2of3MealsFactor;
extern const float kDiagnosis3of3MealsFactor;

extern const float kDiagnosisCarbsFactor;
extern const float kDiagnosisProteinsFactor;
extern const float kDiagnosisFatFactor;

extern NSString *const kDiagnosisThinnessIILabel;
extern NSString *const kDiagnosisThinnessLabel;
extern NSString *const kDiagnosisNormalLabel;
extern NSString *const kDiagnosisOverWeightLabel;
extern NSString *const kDiagnosisObesityLabel;
extern NSString *const kDiagnosisObesityIILabel;
extern NSString *const kDiagnosisObesityIIILabel;

extern NSString *const kDiagnosis1of5MealsLabel;
extern NSString *const kDiagnosis2of5MealsLabel;
extern NSString *const kDiagnosis3of5MealsLabel;
extern NSString *const kDiagnosis4of5MealsLabel;
extern NSString *const kDiagnosis5of5MealsLabel;

// ProfileController defaults keys
extern NSString *const kBodyMeterAgeKey;
extern NSString *const kBodyMeterGenderKey;
extern NSString *const kBodyMeterHeightKey;
extern NSString *const kBodyMeterWeightKey;
extern NSString *const kBodyMeterActivityKey;
extern NSString *const kBodyMeterIdealWeightKey;

//ProfileController constants
extern NSString *const kBodyMeterProfileBackButton;
extern NSString *const kBodyMeterUndefinedLabel;
extern NSString *const kBodyMeterAgeLabel;
extern NSString *const kBodyMeterAgeSufix;
extern NSString *const kBodyMeterGenderLabel;
extern NSString *const kBodyMeterMaleLabel;
extern NSString *const kBodyMeterFemaleLabel;
extern NSString *const kBodyMeterHeightLabel;
extern NSString *const kBodyMeterHeightSufix;
extern NSString *const kBodyMeterWeightLabel;
extern NSString *const kBodyMeterWeightSufix;
extern NSString *const kBodyMeterActivityLabel;
extern NSString *const kBodyMeterMinimalLabel;
extern NSString *const kBodyMeterLightLabel;
extern NSString *const kBodyMeterModerateLabel;
extern NSString *const kBodyMeterIntenseLabel;
extern NSString *const kBodyMeterIdealWeightLabel;
extern NSString *const kBodyMeterProfileHeaderLabel;
extern NSString *const kBodyMeterWeightHeaderLabel;
extern NSString *const kBodyMeterProfileFooterLabel;
extern NSString *const kBodyMeterWeightFooterLabel;
extern NSString *const kBodyMeterProfileAlertTitle;
extern NSString *const kBodyMeterProfileAlertMessage;
extern NSString *const kBodyMeterProfileAlertButton;
extern NSString *const kBodyMeterAgeEntry;
extern NSString *const kBodyMeterHeightEntry;
extern NSString *const kBodyMeterWeightEntry;
extern NSString *const kBodyMeterIdealWeightEntry;
extern NSString *const kBodyMeterEntryAlertCancel;
extern NSString *const kBodyMeterEntryAlertOK;
extern const CGFloat kBodyMeterColor;
extern NSString *const kBodyMeterShowDiagnosisNotification;
extern NSString *const kbodyMeterGoToLauncherNotification;

//DiagnosisController constants
extern NSString *const kBodyMeterDiagnosisBackButton;
extern NSString *const kBodyMeterRangeLabel;
extern NSString *const kBodyMeterCMILabel;
extern NSString *const kBodyMeterResultLabel;
extern NSString *const kBodyMeterCalorieConsumptionLabel;
extern NSString *const kBodyMeterTimeLabel;
extern NSString *const kBodyMeterEnergyConsumptionLabel;
extern NSString *const kBodyMeterRecomendationsLabel;
extern NSString *const kBodyMeterDiagnosisLabel;
extern NSString *const kBodyMeterGoalLabel;
extern NSString *const kBodyMeterCMISufix;
extern NSString *const kBodyMeterConsumptionSufix;
extern NSString *const kBodyMeterTimeSufix;
extern const CGFloat kBodyMeterBannerWidth;
extern const CGFloat kBodyMeterBannerHeight;
extern NSString *const kBodyMeterBannerImage;
extern NSString *const kBodyMeterBackgroundImage;

// ConsumptionController constants
extern NSString *const kBodyMeterConsumptionBackButton;
extern NSString *const kBodyMeterMealsADay;

// MealsController constants
extern NSString *const kBodyMeterMealsBackButton;
extern NSString *const kBodyMeterCaloriesLabel;
extern NSString *const kBodyMeterCarbohidratesLabel;
extern NSString *const kBodyMeterProteinsLabel;
extern NSString *const kBodyMeterFatLabel;
extern NSString *const kBodyMeterCaloriesSufix;
extern NSString *const kBodyMeterGramsSufix;

// RecomendationsController constants
extern NSString *const kBodyMeterRecomendationsBackButton;
extern NSString *const kRecomendationsThinnessII;
extern NSString *const kRecomendationsThinness;
extern NSString *const kRecomendationsNormal;
extern NSString *const kRecomendationsOverWeight;
extern NSString *const kRecomendationsObesity;
extern NSString *const kRecomendationsObesityII;
extern NSString *const kRecomendationsObesityIII;

// Launcher Title
extern NSString *const kBodyMeterTitle;

// Controller URLs
extern NSString *const kURLBodyMeterProfile;
extern NSString *const kURLBodyMeterDiagnosis;

// Controller URL's call
extern NSString *const kURLBodyMeterProfileCall;
extern NSString *const kURLBodyMeterDiagnosisCall;