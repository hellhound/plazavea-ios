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

// Endpoint URLs
NSString *const kURLWineDetailEndPoint = ENDPOINT(@"/wines/%@/details.json");