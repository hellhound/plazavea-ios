#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

@interface Region: NSObject
{
    NSNumber *_regionId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *regionId;
@property (nonatomic, copy) NSString *name;

+ (id)regionFromDictionaty:(NSDictionary *)rawRegion;
@end

@interface RegionCollection: URLRequestModel
{
    NSMutableArray *_regions;
}
@property (nonatomic, readonly) NSArray *regions;

+ (id)RegionCollectionFromDictionary:(NSDictionary *)rawCollection;

- (void)copyPropertiesFromRegionCollection:(RegionCollection *)collection;
@end