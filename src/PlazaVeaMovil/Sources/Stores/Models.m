#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"

// RegionCollection's key path
static NSString *const kMutableRegionsKey = @"regions";

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

+ (id)regionFromDictionaty:(NSDictionary *)rawRegion
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
#pragma mark RegionCollectin (Public)

+ (id)RegionCollectionFromDictionary:(NSDictionary *)rawCollection
{
    RegionCollection * collection = [[[RegionCollection alloc] init]
            autorelease];
    NSArray *regions;
    NSMutableArray *mutableRegions =
            [collection mutableArrayValueForKey:kMutableRegionsKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((regions =
            [rawCollection objectForKey:kRegionCollectionRegions]) == nil)
        return nil;
    if (![regions isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawRegion in regions) {
        Region *region = [Region regionFromDictionaty:rawRegion];
        
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
            [RegionCollection RegionCollectionFromDictionary:rootObject];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromRegionCollection:collection];
    [super requestDidFinishLoad:request];
}
@end