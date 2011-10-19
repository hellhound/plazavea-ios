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

// Endpoint URLs
NSString *const kRegionListEndPoint = ENDPOINT(@"/regions/listing.json");