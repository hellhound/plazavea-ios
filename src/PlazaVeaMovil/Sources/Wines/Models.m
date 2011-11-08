#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Wines/Constants.h"
#import "Wines/Models.h"

static NSString *const kMutableExtraPictureURLsKey = @"extraPictureURLs";

@implementation Wine

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _extraPictureURLs = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_wineId release];
    [_code release];
    [_name release];
    [_milliliters release];
    [_pictureURL release];
    [_extraPictureURLs release];
    [_price release];
    [_harvestYear release];
    [_barrel release];
    [_look release];
    [_taste release];
    [_smell release];
    [_temperature release];
    [_cellaring release];
    [_oxygenation release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (KeyValueCoding)

@synthesize extraPictureURLs = _extraPictureURLs;

- (void)        insertObject:(NSURL *)extraURL 
   inExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPictureURLs insertObject:extraURL atIndex:index];
}

- (void)insertExtraPictureURLs:(NSArray *)extraURLs
                     atIndexes:(NSIndexSet *)indexes
{
    [_extraPictureURLs removeObjectsAtIndexes:indexes];
}

- (void)removeObjectFromExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPictureURLs removeObjectAtIndex:index];
}

- (void)removeExtraPictureURLsAtIndexes:(NSIndexSet *)indexes
{
    [_extraPictureURLs removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark Wine (Public)

@synthesize wineId = _wineId, code = _code, name = _name, 
        milliliters = _milliliters, pictureURL= _pictureURL, price = _price,
            harvestYear = _harvestYear, barrel = _barrel, look = _look,
            taste = _taste, smell = _smell, temperature = _temperature,
            cellaring = _cellaring, oxygenation = _oxygenation;

+ (id)shortWineFromDictionary:(NSDictionary *)rawWine
{
    NSNumber *wineId, *milliliters, *price;
    NSString *name, *pictureURL;
    
    if (![rawWine isKindOfClass:[NSDictionary class]])
        return nil;
    if ((wineId = [rawWine objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![wineId isKindOfClass:[NSNumber class]])
        return nil;
    if ((milliliters = [rawWine objectForKey:kWineMillilitersKey]) == nil)
        return nil;
    if (![milliliters isKindOfClass:[NSNumber class]])
        return nil;
    if ((price = [rawWine objectForKey:kWinePriceKey]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawWine objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawWine objectForKey:kWinePictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }
    Wine *wine = [[[Wine alloc] init] autorelease];
    
    [wine setWineId:wineId];
    [wine setMilliliters:milliliters];
    [wine setPrice:price];
    [wine setName:name];
    if (pictureURL)
        [wine setPictureURL:[NSURL URLWithString:pictureURL]];
    return wine;
}

+ (id)wineFromDictionary:(NSDictionary *)rawWine
{
    NSNumber *wineId, *milliliters, *price, *harvestYear, *temperature,
            *cellaring, *oxygenation;
    NSString *code, *name, *barrel, *look, *taste, *smell, *pictureURL;
    NSArray *extrasPictureURLs;
    
    if (![rawWine isKindOfClass:[NSDictionary class]])
        return nil;
    if ((wineId = [rawWine objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![wineId isKindOfClass:[NSNumber class]])
        return nil;
    if ((milliliters = [rawWine objectForKey:kWineMillilitersKey]) == nil)
        return nil;
    if (![milliliters isKindOfClass:[NSNumber class]])
        return nil;
    if ((price = [rawWine objectForKey:kWinePriceKey]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]])
        return nil;
    if ((harvestYear = [rawWine objectForKey:kWineHarvestYearKey]) == nil)
        return nil;
    if (![harvestYear isKindOfClass:[NSNumber class]])
        return nil;
    if ((temperature = [rawWine objectForKey:kWineTemperatureKey]) == nil)
        return nil;
    if (![temperature isKindOfClass:[NSNumber class]])
        return nil;
    if ((cellaring = [rawWine objectForKey:kWineCellaringKey]) == nil)
        return nil;
    if (![cellaring isKindOfClass:[NSNumber class]])
        return nil;
    if ((oxygenation = [rawWine objectForKey:kWineOxygenationKey]) == nil)
        return nil;
    if (![oxygenation isKindOfClass:[NSNumber class]])
        return nil;
    if ((code = [rawWine objectForKey:kWineCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((name = [rawWine objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((barrel = [rawWine objectForKey:kWineBarrelKey]) == nil)
        return nil;
    if (![barrel isKindOfClass:[NSString class]])
        return nil;
    if ((look = [rawWine objectForKey:kWineLookKey]) == nil)
        return nil;
    if (![look isKindOfClass:[NSString class]])
        return nil;
    if ((taste = [rawWine objectForKey:kWineTasteKey]) == nil)
        return nil;
    if (![taste isKindOfClass:[NSString class]])
        return nil;
    if ((smell = [rawWine objectForKey:kWineSmellKey]) == nil)
        return nil;
    if (![smell isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawWine objectForKey:kWinePictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }
    if ((extrasPictureURLs =
            [rawWine objectForKey:kWineExtraPicturesKey]) == nil)
        return nil;
    if (![extrasPictureURLs isKindOfClass:[NSArray class]])
        return nil;
    
    Wine *wine = [[[Wine alloc] init] autorelease];
    NSMutableArray *mutableExtraPicturesURLs =
            [wine mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    for (NSString *extraPictureURL in extrasPictureURLs) {
        if (![extraPictureURL isKindOfClass:[NSString class]])
            return nil;
        [mutableExtraPicturesURLs addObject:
                [NSURL URLWithString:extraPictureURL]];
    }
    [wine setWineId:wineId];
    [wine setCode:code];
    [wine setName:name];
    [wine setMilliliters:milliliters];
    if (pictureURL)
        [wine setPictureURL:[NSURL URLWithString:pictureURL]];
    [wine setPrice:price];
    [wine setHarvestYear:harvestYear];
    [wine setBarrel:barrel];
    [wine setLook:look];
    [wine setTaste:taste];
    [wine setSmell:smell];
    [wine setTemperature:temperature];
    [wine setCellaring:cellaring];
    [wine setOxygenation:oxygenation];
    return wine;
}

- (id)initWithWineId:(NSString *)wineId
{
    NSInteger wineIntegerId = [wineId integerValue];
    if (wineIntegerId < 0)
        return nil;
    if ((self = [super init]) != nil) {
        [self setWineId:[NSNumber numberWithInteger:wineIntegerId]];
    }
    return self;
}

- (void)copyPropertiesFromWine:(Wine *)wine
{
    [self setWineId:[wine wineId]];
    [self setCode:[[wine code] copy]];
    [self setName:[[wine name] copy]];
    [self setMilliliters:[wine milliliters]];
    [self setPictureURL:[wine pictureURL]];
    [self setPrice:[wine price]];
    [self setHarvestYear:[wine harvestYear]];
    [self setBarrel:[[wine barrel] copy]];
    [self setLook:[[wine look] copy]];
    [self setTaste:[[wine taste] copy]];
    [self setSmell:[[wine smell] copy]];
    [self setTemperature:[wine temperature]];
    [self setCellaring:[wine cellaring]];
    [self setOxygenation:[wine oxygenation]];
    
    NSMutableArray *extraPictureURLs =
    [self mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    
    for (NSURL *extraPictureURL in [wine extraPictureURLs])
        [extraPictureURLs addObject:extraPictureURL];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kURLWineDetailEndPoint, _wineId) delegate:self];
        
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
    Wine *wine = [Wine wineFromDictionary:rootObject];
    
    if (wine == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromWine:wine];
    [super requestDidFinishLoad:request];
}
@end