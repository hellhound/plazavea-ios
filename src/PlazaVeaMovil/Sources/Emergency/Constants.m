// Emergency-number module's constants
#import <Foundation/Foundation.h>

#import "Emergency/Constants.h"

// EmergencyCategory model's constants

// Administration of Emergency numbers
NSString *const kEmergencyCategoryTitle = @"Num. Emergencia";
// NSLocalizedString(@"Num. Emergencia", nil)

NSString *const kEmergencyInitialCSV = @"emergency-initial-data";

NSString *const kEmergencyCategoryEntity = @"EmergencyCategory";
NSString *const kEmergencyCategoryClass = @"EmergencyCategory";
NSString *const kEmergencyCategoryName = @"name";
NSString *const kEmergencyCategoryNumbers = @"numbers";

// EmergencyNumber model's constants

NSString *const kEmergencyNumberTitle = @"Num. Emergencia";
// NSLocalizedString(@"Num. Emergencia", nil)

NSString *const kEmergencyNumberEntity = @"EmergencyNumber";
NSString *const kEmergencyNumberClass = @"EmergencyNumber";
NSString *const kEmergencyNumberName = @"name";
NSString *const kEmergencyNumberPhone = @"phone";
NSString *const kEmergencyNumberCategory = @"category";
NSString *const kEmergencyNumberFirstLetter = @"uppercaseFirstLetterOfName";

// EmergencyFile model's constants

NSString *const kEmergencyFileName = @"name";

// Controller URLs

NSString *const kURLEmergencyCategory = @"tt://launcher/emergencycategories/";
