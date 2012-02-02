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

// Launcher Title
extern NSString *const kBodyMeterTitle;

// Controller URLs
extern NSString *const kURLBodyMeterProfile;

// Controller URL's call
extern NSString *const kURLBodyMeterProfileCall;