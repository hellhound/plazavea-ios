// Emergency-number module's constants
#import <Foundation/Foundation.h>

#import "Emergency/Constants.h"

// EmergencyCategory model's constants

// Administration of Emergency numbers
NSString *const kEmergencyCategoryTitle = @"Categorías";
// NSLocalizedString(@"Categorías", nil)

NSString *const kEmergencyCategoryEntity = @"EmergencyCategory";
NSString *const kEmergencyCategoryClass = @"EmergencyCategory";
NSString *const kEmergencyCategoryName = @"name";
NSString *const kEmergencyCategoryNumbers = @"numbers";

// EmergencyNumber model's constants

NSString *const kEmergencyNumberEntity = @"EmergencyNumber";
NSString *const kEmergencyNumberClass = @"EmergencyNumber";
NSString *const kEmergencyNumberName = @"name";
NSString *const kEmergencyNumberPhone = @"phone";
NSString *const kEmergencyNumberCategory = @"category";

// Controller URLs

NSString *const kURLEmergencyCategory = @"tt://launcher/emergencycategories/";
