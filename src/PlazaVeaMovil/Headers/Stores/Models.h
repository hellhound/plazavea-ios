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

@interface Store: NSObject
{
    NSNumber *_storeId;
    NSString *_name;
    NSString *_address;
    NSString *_picture;
    NSNumber *_latitude;
    NSNumber *_longitude;
}
@property (nonatomic, retain) NSNumber *storeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, retain) NSString *picture;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

+ (id)shortStoreFromDictionary:(NSDictionary *)rawStore;
@end

@interface StoreCollection: URLRequestModel
{
    NSNumber *_subregionId;
    NSMutableArray *_stores;
    NSMutableArray *_storesTitles;
}
@property (nonatomic, readonly) NSArray *stores;
@property (nonatomic, readonly) NSArray *storesTitles;

+ (id)storeCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithSubregionId:(NSString *)subregionId;
- (void)copyPropertiesFromStoreCollection:(StoreCollection *)collection;
@end