#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"

// RegionCollection's key path
static NSString *const kMutableRegionsKey = @"regions";

// SubregionCollection's key path
static NSString *const kMUtableSubregionsKey = @"subregions";

// StoreCollection's key path
static NSString *const kMutableStoresKey = @"stores";
static NSString *const kMutableStoreTitlesKey = @"districts";

// Store's key pathes
static NSString *const kMutableServicesKey = @"services";

@implementation Subregion

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_subregionId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize subregionId = _subregionId, name = _name;

+ (id)subregionFromDictionary:(NSDictionary *)rawSubregion
{
    NSNumber *subregionId;
    NSString *name;
    if (![rawSubregion isKindOfClass:[NSDictionary class]])
        return nil;
    if ((subregionId = [rawSubregion objectForKey:kRegionIdKey]) == nil)
        return nil;
    if (![subregionId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawSubregion objectForKey:kRegionNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Subregion *subregion = [[[Subregion alloc] init] autorelease];
    
    [subregion setSubregionId:subregionId];
    [subregion setName:name];
    return subregion;
}
@end

@interface SubregionCollection ()

@property (nonatomic, retain) NSNumber *regionId;
@end

@implementation SubregionCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _subregions = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_subregions release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize subregions = _subregions;

- (void)    insertObject:(Subregion *)subregion
     inSubregionsAtIndex:(NSUInteger)index
{
    [_subregions insertObject:subregion atIndex:index];
}

- (void)insertSubregions:(NSArray *)subregions atIndexes:(NSIndexSet *)indexes
{
    [_subregions insertObjects:subregions atIndexes:indexes];
}

- (void)removeObjectFromSubregionsAtIndex:(NSUInteger)index
{
    [_subregions removeObjectAtIndex:index];
}

- (void)removeSubregionsAtIndexes:(NSIndexSet *)indexes
{
    [_subregions removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark SubregionCollection (Public)

@synthesize regionId = _regionId;

+ (id)subregionCollectionFromDictionary:(NSDictionary *)rawCollection
{
    SubregionCollection *collection = [[[SubregionCollection alloc] init]
            autorelease];
    NSArray *subregions;
    NSMutableArray *mutableSubregions =
            [collection mutableArrayValueForKey:kMUtableSubregionsKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((subregions =
        [rawCollection objectForKey:kSubregionCollectionRegionsKey]) == nil)
        return nil;
    if (![subregions isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawSubregion in subregions) {
        Subregion *subregion = [Subregion subregionFromDictionary:rawSubregion];
        
        if (subregion == nil)
            return nil;
        [mutableSubregions addObject:subregion];
    }
    return collection;
}

- (id)initWithRegionId:(NSString *)regionId
{
    NSInteger regionIntegerId = [regionId integerValue];
    if (regionIntegerId < 0)
        return nil;
    if ((self = [self init]) != nil)
        [self setRegionId:[NSNumber numberWithInteger:regionIntegerId]];
    return self;
}

- (void)copyPropertiesFromSubregionCollection:(SubregionCollection *)collection
{
    NSMutableArray *mutableSubregions =
            [self mutableArrayValueForKey:kMUtableSubregionsKey];
    
    [mutableSubregions addObjectsFromArray:[collection subregions]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kSubregionListEndPoint, _regionId) delegate:self];
        
        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject = [(TTURLJSONResponse *)[request response]
            rootObject];
    SubregionCollection *collection = [SubregionCollection
            subregionCollectionFromDictionary:rootObject];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromSubregionCollection:collection];
    [super requestDidFinishLoad:request];
}

@end

@implementation Region

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_count release];
    [_suggested release];
    [_regionId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize regionId = _regionId, name = _name, count = _count,
        suggested = _suggested;

+ (id)shortRegionFromDictionary:(NSDictionary *)rawRegion
{
    NSNumber *regionId;
    NSString *name;
    if (![rawRegion isKindOfClass:[NSDictionary class]])
        return nil;
    if ((regionId = [rawRegion objectForKey:kRegionIdKey]) == nil)
        return nil;
    if (![regionId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawRegion objectForKey:kRegionNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Region *region = [[[Region alloc] init] autorelease];
    
    [region setRegionId:regionId];
    [region setName:name];
    return region;
}

+ (id)regionFromDictionary:(NSDictionary *)rawRegion
{
    Region *region = [self shortRegionFromDictionary:rawRegion];
    
    if (region == nil)
        return nil;
    NSNumber *count;
    NSNumber *suggested;
    if ((count = [rawRegion objectForKey:kRegionCountKey]) == nil)
        return nil;
    if (![count isKindOfClass:[NSNumber class]])
        return nil;
    if ((suggested = [rawRegion objectForKey:kRegionSuggestedKey]) == nil)
        return nil;
    if (![suggested isKindOfClass:[NSNumber class]]) {
        if (![suggested isKindOfClass:[NSNull class]])
            return nil;
        suggested = nil;
    }
    [region setCount:count];
    [region setSuggested:suggested];
    return region;
}
@end

@implementation RegionCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _regions = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_regions release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize regions = _regions;

- (void)insertObject:(Region *)region inRegionsAtIndex:(NSUInteger)index
{
    [_regions insertObject:region atIndex:index];
}

- (void)insertRegions:(NSArray *)regions atIndexes:(NSIndexSet *)indexes
{
    [_regions insertObjects:regions atIndexes:indexes];
}

- (void)removeObjectFromRegionsAtIndex:(NSUInteger)index
{
    [_regions removeObjectAtIndex:index];
}

- (void)removeRegionsAtIndexes:(NSIndexSet *)indexes
{
    [_regions removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark RegionCollection (Public)

+ (id)regionCollectionFromDictionary:(NSDictionary *)rawCollection
{
    RegionCollection *collection = [[[RegionCollection alloc] init]
            autorelease];
    NSArray *regions;
    NSMutableArray *mutableRegions =
            [collection mutableArrayValueForKey:kMutableRegionsKey];
 
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((regions =
            [rawCollection objectForKey:kRegionCollectionRegionsKey]) == nil)
        return nil;
    if (![regions isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawRegion in regions) {
        Region *region = [Region regionFromDictionary:rawRegion];
        
        if (region == nil)
            return nil;
        [mutableRegions addObject:region];
    }
    return collection;
}

- (void)copyPropertiesFromRegionCollection:(RegionCollection *)collection
{
    NSMutableArray *mutableRegions =
            [self mutableArrayValueForKey:kMutableRegionsKey];
    
    [mutableRegions addObjectsFromArray:[collection regions]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest
                requestWithURL:kRegionListEndPoint delegate:self];
        
        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    RegionCollection *collection =
            [RegionCollection regionCollectionFromDictionary:rootObject];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromRegionCollection:collection];
    [super requestDidFinishLoad:request];
}
@end

@implementation Service

#pragma mark -
#pragma mark NSObject
- (void) dealloc
{
    [_serviceId release];
    [_name release];
    [_serviceURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark Service (Public)
@synthesize serviceId = _serviceId, name = _name, serviceURL = _serviceURL;

+ (id)serviceFromDictionary:(NSDictionary *)rawService
{
    NSNumber *serviceId;
    NSString *name;
    NSString *serviceURL;

    if (![rawService isKindOfClass:[NSDictionary class]])
        return nil;
    if ((serviceId = [rawService objectForKey:kServiceIdKey]) == nil)
        return nil;
    if (![serviceId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawService objectForKey:kServiceNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((serviceURL = [rawService objectForKey:kServiceURLKey]) == nil)
        return nil;
    if (![serviceURL isKindOfClass:[NSString class]])
        return nil;

    Service *service = [[[Service alloc] init] autorelease];

    [service setServiceId:serviceId];
    [service setName:name];
    [service setServiceURL:serviceURL];

    return service;
}
@end

@implementation MapAnnotation

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_title release];
    [_subtitle release];
    [super dealloc];
}

#pragma mark -
#pragma mark MapAnnotation

@synthesize coordinate = _coordinate, title = _title, subtitle = _subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate
                    title:(NSString *)title
              andSubtitle:(NSString *)subtitle
{
    if ((self = [self init]) != nil) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
    }
    return  self;
}

@end

@implementation Store

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        // Initialiazing only the mutable arrays
        _services = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_storeId release];
    [_name release];
    [_storeAddress release];
    [_pictureURL release];
    [_code release];
    [_attendance release];
    [_region release];
    [_subregion release];
    [_district release];
    [_ubigeo release];
    [_latitude release];
    [_longitude release];
    [_services release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize services = _services;

- (void)insertObject:(Service *)service
   inServicesAtIndex:(NSUInteger)index
{
    [_services insertObject:service atIndex:index];
}

- (void)insertServices:(NSArray *)services
                     atIndexes:(NSIndexSet *)indexes
{
    [_services insertObjects:services atIndexes:indexes];
}

- (void)removeObjectFromServicesAtIndex:(NSUInteger)index
{
    [_services removeObjectAtIndex:index];
}

- (void)removeServicesAtIndexes:(NSIndexSet *)indexes
{
    [_services removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark Store (Public)

@synthesize storeId = _storeId, name = _name, code = _code,
        storeAddress = _storeAddress, attendance = _attendance,
            pictureURL = _pictureURL, region = _region, district = _district,
            subregion = _subregion, ubigeo = _ubigeo, phones = _phones,
            latitude = _latitude, longitude = _longitude;

+ (id)shortStoreFromDictionary:(NSDictionary *)rawStore 
       whithLatitudeInLocation:(BOOL)latitudeInLocation;
{
    NSNumber *storeId, *latitude, *longitude;
    NSString *name, *address, *pictureURL;
    
    if (![rawStore isKindOfClass:[NSDictionary class]])
        return nil;
    if ((storeId = [rawStore objectForKey:kStoreIdKey]) == nil)
        return nil;
    if (![storeId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawStore objectForKey:kStoreNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((address = [rawStore objectForKey:kStoreAdressKey]) == nil)
        return nil;
    if (![address isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawStore objectForKey:kStorePictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]])
        return nil;
    if (latitudeInLocation) {
        //TODO:Implement
        latitude = nil;
        longitude = nil;
    } else {
        if ((latitude = [rawStore objectForKey:kStoreLatitudeKey]) == nil)
            return nil;
        if (![latitude isKindOfClass:[NSNumber class]])
            return nil;
        if ((longitude = [rawStore objectForKey:kStoreLongitudeKey]) == nil)
            return nil;
        if (![longitude isKindOfClass:[NSNumber class]])
            return nil;
    }
    Store *store = [[[Store alloc] init] autorelease];
    [store setStoreId:storeId];
    [store setName:name];
    [store setStoreAddress:address];
    if (pictureURL)
        [store setPictureURL:[NSURL URLWithString:pictureURL]];
    [store setLatitude:latitude];
    [store setLongitude:longitude];
    return store;
}

+ (id)storeFromDictionary:(NSDictionary *)rawStore
{
    Store *store = [self shortStoreFromDictionary:rawStore 
            whithLatitudeInLocation:YES];
    
    if (store == nil)
        return nil;

    NSNumber *latitude, *longitude;
    NSString *code, *phones, *attendance, *ubigeo;
    NSDictionary *rawLocation, *rawRegion, *rawSubregion, *rawDistrict;
    NSArray *services;
    NSMutableArray *mutableServices =
            [store mutableArrayValueForKey:kMutableServicesKey]; 
    Region *region;
    Subregion *subregion, *district;

    if ((code = [rawStore objectForKey:kStoreCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]]){
        if (![code isKindOfClass:[NSNull class]])
            return nil;
        code = nil;
    }
    if ((attendance = [rawStore objectForKey:kStoreAttendanceKey]) == nil)
        return nil;
    if (![attendance isKindOfClass:[NSString class]]){
        if (![attendance isKindOfClass:[NSNull class]])
            return nil;
        attendance = nil;
    }
    if ((rawLocation = [rawStore objectForKey:kStoreLocationKey]) == nil)
        return nil;
    if (![rawLocation isKindOfClass:[NSDictionary class]]){
        if (![rawLocation isKindOfClass:[NSNull class]])
            return nil;
    } else {
        if ((rawRegion = [rawLocation objectForKey:kStoreRegionKey]) == nil)
            return nil;
        region = [Region shortRegionFromDictionary:rawRegion];
        if (region == nil)
            return nil;
        if ((rawSubregion =
                [rawLocation objectForKey:kStoreSubregionKey]) == nil)
            return nil;
        subregion = [Subregion subregionFromDictionary:rawSubregion];
        if (subregion == nil)
            return nil;
        if ((rawDistrict =
                [rawLocation objectForKey:kStoreDisctrictKey]) == nil)
            return nil;
        district = [Subregion subregionFromDictionary:rawDistrict];
        if (district == nil)
            return nil;
        if ((ubigeo = [rawLocation objectForKey:kStoreUbigeoKey]) == nil)
            return nil;
        if (![ubigeo isKindOfClass:[NSString class]])
            return nil;
        if ((latitude = [rawLocation objectForKey:kStoreLatitudeKey]) == nil)
            return nil;
        if (![latitude isKindOfClass:[NSNumber class]])
            return nil;
        if ((longitude = [rawLocation objectForKey:kStoreLongitudeKey]) == nil)
            return nil;
        if (![longitude isKindOfClass:[NSNumber class]])
            return nil;
    }
    if ((phones = [rawStore objectForKey:kStorePhonesKey]) == nil)
        return nil;
    if (![phones isKindOfClass:[NSString class]]){
        if (![phones isKindOfClass:[NSNull class]])
            return nil;
        phones = nil;
    }
    if ((services = [rawStore objectForKey:kStoreServicesKey]) == nil)
        return nil;
    if (![services isKindOfClass:[NSArray class]])
        return nil;
    [store setCode:code];
    [store setAttendance:attendance];
    [store setRegion:region];
    [store setSubregion:subregion];
    [store setUbigeo:ubigeo];
    [store setLatitude:latitude];
    [store setLongitude:longitude];
    [store setDistrict:district];
    [store setPhones:phones];
    for (NSDictionary *rawService in services) {
        Service *service = [Service serviceFromDictionary:rawService];
        if (service == nil)
            return nil;
        [mutableServices addObject:service];
    }
    return store;
}

- (id)initWithStoreId:(NSString *)storeId
{
    NSInteger storeIntegerId = [storeId integerValue];
    if(storeIntegerId < 0) {
        return nil;
    }
    if((self = [self init]) != nil)
        [self setStoreId:[NSNumber numberWithInteger:storeIntegerId]];
    return self;
}

- (void)copyPropertiesFromStore:(Store *)store
{
    [self setStoreId:[store storeId]];
    [self setCode:[[store code] copy]];
    [self setName:[[store name] copy]];
    [self setStoreAddress:[[store storeAddress] copy]];
    [self setAttendance:[[store attendance] copy]];
    [self setPictureURL:[store pictureURL]];
    [self setPhones:[[store phones] copy]];
    [self setRegion:[store region]];
    [self setSubregion:[store subregion]];
    [self setDistrict:[store district]];
    [self setUbigeo:[[store ubigeo] copy]];
    [self setLatitude:[store latitude]];
    [self setLongitude:[store longitude]];

    NSMutableArray *services =
            [self mutableArrayValueForKey:kMutableServicesKey]; 

    for (Service *service in [store services])
        [services addObject:service];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kStoreDetailEndPoint, _storeId) delegate:self]; 

        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    Store *store = [Store storeFromDictionary:rootObject];
    
    if (store == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
            tryAgain:NO];
        return;
    }
    [self copyPropertiesFromStore:store];
    [super requestDidFinishLoad:request];
}
@end

@interface StoreCollection ()

@property (nonatomic, retain) NSNumber *subregionId;
@property (nonatomic, retain) NSNumber *regionId;
@end

@implementation StoreCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        _stores = [[NSMutableArray alloc] init];
        _districts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_stores release];
    [_districts release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize stores = _stores, districts = _districts;

- (void)insertObject:(Store *)store inStoresAtIndex:(NSUInteger)index
{
    [_stores insertObject:store atIndex:index];
}

- (void)insertStores:(NSArray *)stores atIndexes:(NSIndexSet *)indexes
{
    [_stores insertObjects:stores atIndexes:indexes];
}

- (void)removeObjectFromStoresAtIndex:(NSUInteger)index
{
    [_stores removeObjectAtIndex:index];
}

- (void)removeStoresAtIndexes:(NSIndexSet *)indexes
{
    [_stores removeObjectsAtIndexes:indexes];
}

- (void)insertObject:(NSString *)district inDistrictsAtIndex:(NSUInteger)index
{
    [_districts insertObject:district atIndex:index];
}

- (void)insertDistricts:(NSArray *)districts
                 atIndexes:(NSIndexSet *)indexes
{
    [_districts insertObjects:districts atIndexes:indexes];
}

- (void)removeObjectFromDistrictsAtIndex:(NSUInteger)index
{
    [_districts removeObjectAtIndex:index];
}

- (void)removeDistrictsAtIndexes:(NSIndexSet *)indexes
{
    [_districts removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark StoreCollection

@synthesize subregionId = _subregionId, regionId = _regionId;

+ (id)storeCollectionFromDictionary:(NSDictionary *)rawCollection
{
    StoreCollection *collection = [[[StoreCollection alloc] init] autorelease];
    NSArray *districts;
    NSMutableArray *mutableStores =
            [collection mutableArrayValueForKey:kMutableStoresKey];
    NSMutableArray *mutableDistricts =
            [collection mutableArrayValueForKey:kMutableStoreTitlesKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((districts = [rawCollection objectForKey:kStoreCollectionDistrictsKey])
            == nil)
        return nil;
    if (![districts isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *district in districts) {
        NSArray *rawStores;
        NSString *sectionName;
        NSNumber *sectionId;
        
        if  (![district isKindOfClass:[NSDictionary class]])
            return nil;
        if ((sectionName = [district objectForKey:kStoreCollectionNameKey])
                == nil)
            return nil;
        if (![sectionName isKindOfClass:[NSString class]])
            return nil;
        if ((sectionId = [district objectForKey:kStoreCollectionIdKey])
                == nil)
            return nil;
        if (![sectionId isKindOfClass:[NSNumber class]])
            return nil;
        if ((rawStores = [district objectForKey:kStoreCollectionStoresKey])
                == nil)
            return nil;
        if (![rawStores isKindOfClass:[NSArray class]])
            return nil;
        
        NSMutableArray *storesInDistrict =
                [NSMutableArray arrayWithCapacity:[rawStores count]];
        
        [mutableDistricts addObject:sectionName];
        for (NSDictionary *rawStore in rawStores) {
            Store *store = [Store shortStoreFromDictionary:rawStore 
                    whithLatitudeInLocation:NO];
            
            if (store == nil)
                return nil;
            [storesInDistrict addObject:store];
        }
        [mutableStores addObject:storesInDistrict];
    }
    return collection;
}

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    NSInteger subregionIntegerId = [subregionId integerValue];
    NSInteger regionIntegerId = [regionId integerValue];
    
    if (subregionIntegerId < 0)
        return nil;
    if (regionIntegerId < 0)
        return nil;
    if ((self = [self init]) != nil) {
        [self setSubregionId:[NSNumber numberWithInteger:subregionIntegerId]];
        [self setRegionId:[NSNumber numberWithInteger:regionIntegerId]];
    }
    return self;
}

- (void)copyPropertiesFromStoreCollection:(StoreCollection *)collection;
{
    NSMutableArray *stores = [self mutableArrayValueForKey:kMutableStoresKey];
    NSMutableArray *storeTitles =
            [self mutableArrayValueForKey:kMutableStoreTitlesKey];
    for (NSString *district in [collection districts])
        [storeTitles addObject:district];
    for (Store *store in [collection stores])
        [stores addObject:store];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kStoreListEndPoint, _regionId, _subregionId) delegate:self]; 
        
        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    StoreCollection *collection =
            [StoreCollection storeCollectionFromDictionary:rootObject];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromStoreCollection:collection];
    [super requestDidFinishLoad:request];
}
@end
