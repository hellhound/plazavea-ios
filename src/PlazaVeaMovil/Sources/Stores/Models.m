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