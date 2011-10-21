#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

@interface Subregion: NSObject
{
    NSNumber *_subregionId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *subregionId;
@property (nonatomic, copy) NSString *name;

+ (id)subregionFromDictionary:(NSDictionary *)rawSubregion;
@end

@interface SubregionCollection: URLRequestModel
{
    NSNumber *_regionId;
    NSMutableArray *_subregions;
}
@property (nonatomic, readonly) NSArray *subregions;

+ (id)subregionCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithRegionId:(NSString *)regionId;
- (void)copyPropertiesFromSubregionCollection:(SubregionCollection *)collection;
@end

@interface Region: NSObject
{
    NSNumber *_regionId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *regionId;
@property (nonatomic, copy) NSString *name;

+ (id)regionFromDictionary:(NSDictionary *)rawRegion;
@end

@interface RegionCollection: URLRequestModel
{
    NSMutableArray *_regions;
}
@property (nonatomic, readonly) NSArray *regions;

+ (id)regionCollectionFromDictionary:(NSDictionary *)rawCollection;

- (void)copyPropertiesFromRegionCollection:(RegionCollection *)collection;
@end
