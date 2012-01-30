#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//ProfileController constants
typedef enum{
    kBodyMeterActivityMinimal,
    kBodyMeterActivityLight,
    kBodyMeterActivityModerate,
    kBodyMeterActivityIntense
}kBodyMeterActivityType;

typedef enum{
    kBodyMeterGenderMale,
    kBodyMeterGenderFemale
}kBodyMeterGenderType;

extern NSString *const kBodyMeterAgeKey;
extern NSString *const kBodyMeterGenderKey;
extern NSString *const kBodyMeterHeightKey;
extern NSString *const kBodyMeterWeightKey;
extern NSString *const kBodyMeterActivityKey;

// Controller URLs
extern NSString *const kURLBodyMeterProfile;

// Controller URL's call
extern NSString *const kURLBodyMeterProfileCall;