#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"

// RegionCollection's key path
static NSString *const kMutableRegionsKey = @"regions";

// SubregionCollection's key path
static NSString *const kMUtableSubregionsKey = @"subregions";

// StoreCollection's key path
static NSString *const kMutableStoresKey = @"stores";
static NSString *const kMutableStoreTitlesKey = @"storesTitles";

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
    [_regionId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize regionId = _regionId, name = _name;

+ (id)regionFromDictionary:(NSDictionary *)rawRegion
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
    [_code release];
    [_address release];
    [_attendance release];
    [_picture release];
    [_region release];
    [_subregion release];
    [_ubigeo release];
    [_latitude release];
    [_longitude release];
    [_services release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize services = _services;
- (void)        insertObject:(Service *)service
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

@synthesize storeId = _storeId, name = _name, code = _code, address = _address,
    attendance = _attendance,  picture = _picture, region = _region, 
    subregion = _subregion, ubigeo = _ubigeo, phones = _phones,
    latitude = _latitude, longitude = _longitude;

+ (id)shortStoreFromDictionary:(NSDictionary *)rawStore 
       whithLatitudeInLocation:(BOOL) latitudeInLocation;
{
    NSNumber *storeId;
    NSString *name;
    NSString *address;
    NSString *picture;
    NSNumber *latitude;
    NSNumber *longitude;
    
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
    if ((picture = [rawStore objectForKey:kStorePictureURLKey]) == nil)
        return nil;
    if (![picture isKindOfClass:[NSString class]])
        return nil;
    if ((latitude = [rawStore objectForKey:kStoreLatitudeKey]) == nil)
        return nil;
    if (![latitude isKindOfClass:[NSNumber class]])
        return nil;
    if (latitudeInLocation) {
        //TODO:Implement
    } else {
        if ((longitude = [rawStore objectForKey:kStoreLongitudeKey]) == nil)
            return nil;
        if (![longitude isKindOfClass:[NSNumber class]])
            return nil;
    }
    Store *store = [[[Store alloc] init] autorelease];
    [store setStoreId:storeId];
    [store setName:name];
    [store setAddress:address];
    [store setPicture:[NSURL URLWithString:picture]];
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

    NSString *code, *phones, *attendance, *ubigeo;
    NSDictionary *rawLocation, *rawRegion, *rawSubregion;
    NSArray *services;
    NSMutableArray *mutableServices =
            [store mutableArrayValueForKey:kMutableServicesKey]; 
    Region *region;
    Subregion *subregion;

    if ((code = [rawStore objectForKey:kStoreCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]]){
        if (![code isKindOfClass:[NSNull class]])
            return nil;
        code=nil;
    }
    if ((attendance = [rawStore objectForKey:kStoreAttendanceKey]) == nil)
        return nil;
    if (![attendance isKindOfClass:[NSString class]]){
        if (![attendance isKindOfClass:[NSNull class]])
            return nil;
        attendance=nil;
    }
    if ((rawLocation = [rawStore objectForKey:kStoreLocationKey]) == nil)
        return nil;
    if (![rawLocation isKindOfClass:[NSDictionary class]]){
        if (![rawLocation isKindOfClass:[NSNull class]])
            return nil;
        if ((rawRegion = [rawLocation objectForKey:kStoreRegionKey]) == nil)
            return nil;
        region = [Region regionFromDictionary:rawRegion];
        if (region == nil)
            return nil;
        if ((rawSubregion = [rawLocation objectForKey:kStoreSubregionKey])
                == nil)
            return nil;
        subregion = [Subregion subregionFromDictionary:rawSubregion];
        if (subregion == nil)
            return nil;
        if ((ubigeo = [rawStore objectForKey:kStoreUbigeoKey]) == nil)
            return nil;
        if (![ubigeo isKindOfClass:[NSString class]])
            return nil;
    }
    if ((phones = [rawStore objectForKey:kStorePhonesKey]) == nil)
        return nil;
    if (![phones isKindOfClass:[NSString class]]){
        if (![phones isKindOfClass:[NSNull class]])
            return nil;
        phones=nil;
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
    [self setAddress:[[store address] copy]];
    [self setAttendance:[[store attendance] copy]];
    [self setPicture:[store picture]];
    [self setRegion:[store region]];
    [self setSubregion:[store subregion]];
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
@end

@implementation StoreCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        _stores = [[NSMutableArray alloc] init];
        _storesTitles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_stores release];
    [_storesTitles release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize stores = _stores, storesTitles = _storesTitles;

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

- (void)    insertObject:(NSString *)storeTitle
   inStoresTitlesAtIndex:(NSUInteger)index
{
    [_storesTitles insertObject:storeTitle atIndex:index];
}

- (void)insertStoresTitles:(NSArray *)storeTitles
                 atIndexes:(NSIndexSet *)indexes
{
    [_storesTitles insertObjects:storeTitles atIndexes:indexes];
}

- (void)removeObjectFromStoresTitlesAtIndex:(NSUInteger)index
{
    [_storesTitles removeObjectAtIndex:index];
}

- (void)removeStoresTitlesAtIndexes:(NSIndexSet *)indexes
{
    [_storesTitles removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark StoreCollection

@synthesize subregionId = _subregionId;

+ (id)storeCollectionFromDictionary:(NSDictionary *)rawCollection
{
    StoreCollection *collection = [[[StoreCollection alloc] init] autorelease];
    NSArray *districts;
    NSMutableArray *mutableStores =
            [collection mutableArrayValueForKey:kMutableStoresKey];
    NSMutableArray *mutableStoresTitles =
            [collection mutableArrayValueForKey:kMutableStoreTitlesKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((districts = [rawCollection objectForKey:kStoreCollectionDistrictsKey])
            == nil)
        return nil;
    if (![districts isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *storeCluster in districts) {
        NSArray *rawStores;
        NSString *sectionName;
        NSNumber *sectionId;
        
        if  (![storeCluster isKindOfClass:[NSDictionary class]])
            return nil;
        if ((sectionName = [storeCluster objectForKey:kStoreCollectionNameKey])
                == nil)
            return nil;
        if (![sectionName isKindOfClass:[NSString class]])
            return nil;
        if ((sectionId = [storeCluster objectForKey:kStoreCollectionIdKey])
                == nil)
            return nil;
        if (![sectionId isKindOfClass:[NSNumber class]])
            return nil;
        if ((rawStores = [storeCluster objectForKey:kStoreCollectionStoresKey])
                == nil)
            return nil;
        if (![rawStores isKindOfClass:[NSArray class]])
            return nil;
        
        NSMutableArray *storesInDistrict =
                [NSMutableArray arrayWithCapacity:[rawStores count]];
        
        [mutableStoresTitles addObject:sectionName];
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
{
    NSInteger subregionIntegerId = [subregionId integerValue];
    if (subregionIntegerId < 0)
        return nil;
    if ((self = [self init]) != nil)
        [self setSubregionId:[NSNumber numberWithInteger:subregionIntegerId]];
    return self;
}

- (void)copyPropertiesFromStoreCollection:(StoreCollection *)collection;
{
    NSMutableArray *stores = [self mutableArrayValueForKey:kMutableStoresKey];
    NSMutableArray *storeTitles =
            [self mutableArrayValueForKey:kMutableStoreTitlesKey];
    for (NSString *storeTitle in [collection storesTitles])
        [storeTitles addObject:storeTitle];
    for (Store *store in [collection stores])
        [stores addObject:store];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kStoreListEndPoint, _subregionId) delegate:self]; 
        
        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

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
    [self requestDidFinishLoad:request];
}
@end
