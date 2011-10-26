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
    NSNumber *_count;
    NSNumber *_suggested;
}
@property (nonatomic, retain) NSNumber *regionId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *count;
@property (nonatomic, retain) NSNumber *suggested;

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

@interface Service : NSObject
{
    NSNumber *_serviceId;
    NSString *_name;
    NSString *_serviceURL;
}
@property (nonatomic, retain) NSNumber *serviceId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *serviceURL;

+ (id)serviceFromDictionary:(NSDictionary *)rawService;
@end

@interface Store: URLRequestModel
{
    NSNumber *_storeId;
    NSString *_name;
    NSString *_storeAddress;
    NSURL *_pictureURL;
    NSString *_code;
    NSString *_attendance;
    Region *_region;
    Subregion *_subregion;
    NSString *_ubigeo;
    NSString *_phones;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSMutableArray *_services;
}
@property (nonatomic, retain) NSNumber *storeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *storeAddress;
@property (nonatomic, retain) NSURL *pictureURL;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *attendance;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) Region *region;
@property (nonatomic, retain) Subregion *subregion;
@property (nonatomic, copy) NSString *ubigeo;
@property (nonatomic, copy) NSString *phones;
@property (nonatomic, readonly) NSArray *services;

+ (id)shortStoreFromDictionary:(NSDictionary *)rawStore 
       whithLatitudeInLocation:(BOOL)latitudeInLocation;
+ (id)storeFromDictionary:(NSDictionary *)rawStore;

- (id)initWithStoreId:(NSString *)storeId;
- (void)copyPropertiesFromStore:(Store *)store;
@end

@interface StoreCollection: URLRequestModel
{
    NSNumber *_regionId;
    NSNumber *_subregionId;
    NSMutableArray *_stores;
    NSMutableArray *_districts;
}
@property (nonatomic, readonly) NSArray *stores;
@property (nonatomic, readonly) NSArray *districts;

+ (id)storeCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId;
- (void)copyPropertiesFromStoreCollection:(StoreCollection *)collection;
@end
