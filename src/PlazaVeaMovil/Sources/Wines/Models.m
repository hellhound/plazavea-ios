#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Wines/Constants.h"
#import "Wines/Models.h"

static NSString *const kMutableExtraPictureURLsKey = @"extraPictureURLs";
static NSString *const kMutableSectionsKey = @"sections";
static NSString *const kMutableSectionTitlesKey = @"sectionTitles";
static NSString *const kMutableStrainsKey = @"strains";
static NSString *const kMutableListKey = @"list";

@implementation Oxygenation

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Oxygenation (Public)

@synthesize unit = _unit, value = _value;

+ (id)oxygenationFromDictionary:(NSDictionary *)rawData
{
    NSNumber *value;
    NSString *unit;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((value = [rawData objectForKey:kWineOxygenationValueKey]) == nil)
        return nil;
    if (![value isKindOfClass:[NSNumber class]])
        return nil;
    if ((unit = [rawData objectForKey:kWineOxygenationUnitKey]) == nil)
        return nil;
    if (![unit isKindOfClass:[NSString class]])
        return nil;
    
    Oxygenation *oxygenation = [[[Oxygenation alloc] init] autorelease];
    
    [oxygenation setUnit:unit];
    [oxygenation setValue:value];
    return oxygenation;
}
@end

@implementation GenericFeature

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_featureId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize featureId = _featureId, name = _name;

+ (id)featureFromDictionary:(NSDictionary *)rawData featureKey:(NSString *)key
{
    NSNumber *featureId;
    NSString *name;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((featureId = [rawData objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![featureId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    GenericFeature *feature = [[[GenericFeature alloc] init] autorelease];
    
    [feature setFeatureId:featureId];
    [feature setName:name];
    return feature;
}

+ (id)featureWithId:(NSNumber *)featureId name:(NSString *)name
{
    GenericFeature *feature = [[[GenericFeature alloc] init] autorelease];
    
    [feature setFeatureId:featureId];
    [feature setName:name];
    return feature;
}
@end

@implementation Country

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_countryId release];
    [_name release];
    [_code release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize countryId = _countryId, name = _name, code = _code;

+ (id)countryFromDictionary:(NSDictionary *)rawData
{
    NSNumber *modelId;
    NSString *name, *code;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    modelId = [rawData objectForKey:kWineIdKey];
    if (![modelId isKindOfClass:[NSNumber class]]) {
        if (![modelId isKindOfClass:[NSNull class]]) {
            //return nil;
        }
    }
    code = [rawData objectForKey:kWineCountryCodeKey];
    if (![code isKindOfClass:[NSString class]]) {
        if (![code isKindOfClass:[NSNull class]]) {
            //return nil;
        }
    }
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Country *model = [[[Country alloc] init] autorelease];
    
    [model setCountryId:modelId];
    [model setName:name];
    [model setCode:code];
    return model;
}
@end

@implementation WineRegion

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

+ (id)regionFromDictionary:(NSDictionary *)rawData
{
    NSNumber *modelId;
    NSString *name;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((modelId = [rawData objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![modelId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    WineRegion *model = [[[WineRegion alloc] init] autorelease];
    
    [model setRegionId:modelId];
    [model setName:name];
    return model;
}
@end

@implementation Brand

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_brandId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize brandId = _brandId, name = _name;

+ (id)brandFromDictionary:(NSDictionary *)rawData
{
    NSNumber *modelId;
    NSString *name;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((modelId = [rawData objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![modelId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Brand *model = [[[Brand alloc] init] autorelease];
    
    [model setBrandId:modelId];
    [model setName:name];
    return model;
}
@end

@implementation Kind

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_kindId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize kindId = _kindId, name = _name;

+ (id)kindFromDictionary:(NSDictionary *)rawData
{
    NSNumber *modelId;
    NSString *name;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((modelId = [rawData objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![modelId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Kind *model = [[[Kind alloc] init] autorelease];
    
    [model setKindId:modelId];
    [model setName:name];
    return model;
}
@end

@implementation Winery

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_wineryId release];
    [_name release];
    [super dealloc];
}

#pragma mark -
#pragma mark Region (Public)

@synthesize wineryId = _wineryId, name = _name;

+ (id)wineryFromDictionary:(NSDictionary *)rawData
{
    NSNumber *modelId;
    NSString *name;
    if (![rawData isKindOfClass:[NSDictionary class]])
        return nil;
    if ((modelId = [rawData objectForKey:kWineIdKey]) == nil)
        return nil;
    if (![modelId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawData objectForKey:kWineNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    
    Winery *model = [[[Winery alloc] init] autorelease];
    
    [model setWineryId:modelId];
    [model setName:name];
    return model;
}
@end

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
    [_tasting release];
    [_temperature release];
    [_cellaring release];
    [_oxygenation release];
    [_country release];
    [_region release];
    [_brand release];
    [_kind release];
    [_winery release];
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
    [_extraPictureURLs insertObjects:extraURLs atIndexes:indexes];
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
            harvestYear = _harvestYear, barrel = _barrel,
            tasting = _tasting, temperature = _temperature,
            cellaring = _cellaring, oxygenation = _oxygenation,
            country = _country, region = _region, brand = _brand, kind = _kind,
            winery = _winery, bottleImageURL = _bottleImageURL;

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
    Wine *wine = [self shortWineFromDictionary:rawWine];
    
    if (wine == nil)
        return nil;
    
    NSNumber *harvestYear, *temperature, *cellaring;
    NSString *code, *barrel, *tasting, *bottleImageURL;
    NSDictionary *rawCountry, *rawRegion, *rawBrand, *rawKind, *rawWinery,
            *rawOxygenation, *rawBottles;
    Oxygenation *oxygenation;
    Country *country;
    WineRegion *region;
    Brand *brand;
    Kind *kind;
    Winery *winery;
    
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
    if ((code = [rawWine objectForKey:kWineCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((barrel = [rawWine objectForKey:kWineBarrelKey]) == nil)
        return nil;
    if (![barrel isKindOfClass:[NSString class]])
        return nil;
    if ((tasting = [rawWine objectForKey:kWineTastingKey]) == nil)
        return nil;
    if (![tasting isKindOfClass:[NSString class]])
        return nil;
    if ((rawOxygenation = [rawWine objectForKey:kWineOxygenationKey]) == nil)
        return nil;
    if ((oxygenation =
         [Oxygenation oxygenationFromDictionary:rawOxygenation]) == nil)
        return nil;
    if ((rawCountry = [rawWine objectForKey:kWineCountryKey]) == nil)
        return nil;
    country = [Country countryFromDictionary:rawCountry];
    if (country == nil)
        return nil;
    if ((rawRegion = [rawWine objectForKey:kWineRegionKey]) == nil)
        return nil;
    region = [WineRegion regionFromDictionary:rawRegion];
    if (region == nil)
        return nil;
    if ((rawBrand = [rawWine objectForKey:kWineBrandKey]) == nil)
        return nil;
    brand = [Brand brandFromDictionary:rawBrand];
    if (brand == nil)
        return nil;
    if ((rawKind = [rawWine objectForKey:kWineKindKey]) == nil)
        return nil;
    kind = [Country countryFromDictionary:rawKind];
    if (kind == nil)
        return nil;
    if ((rawWinery = [rawWine objectForKey:kWineWineryKey]) == nil)
        return nil;
    winery = [Country countryFromDictionary:rawWinery];
    if (winery == nil)
        return nil;
    if ((rawBottles = [rawWine objectForKey:kWineExtraPicturesKey]) == nil)
        return nil;
    if (![rawBottles isKindOfClass:[NSDictionary class]])
        return nil;
    if ((bottleImageURL =
            [rawBottles objectForKey:kWineBottlePictureKey]) == nil)
        return nil;
    if (![bottleImageURL isKindOfClass:[NSString class]]) {
        if (![bottleImageURL isKindOfClass:[NSNull class]]) {
            return nil;
        }
    }
    [wine setCode:code];
    [wine setHarvestYear:harvestYear];
    [wine setBarrel:barrel];
    [wine setTasting:tasting];
    [wine setTemperature:temperature];
    [wine setCellaring:cellaring];
    [wine setOxygenation:oxygenation];
    [wine setCountry:country];
    [wine setRegion:region];
    [wine setBrand:brand];
    [wine setKind:kind];
    [wine setWinery:winery];
    [wine setBottleImageURL:bottleImageURL];
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
    [self setTasting:[[wine tasting] copy]];
    [self setTemperature:[wine temperature]];
    [self setCellaring:[wine cellaring]];
    [self setOxygenation:[wine oxygenation]];
    [self setCountry:[wine country]];
    [self setRegion:[wine region]];
    [self setBrand:[wine brand]];
    [self setKind:[wine kind]];
    [self setWinery:[wine winery]];
    [self setBottleImageURL:[wine bottleImageURL]];
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

@implementation WineCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        // Initialiazing only the mutable arrays
        _sections = [[NSMutableArray alloc] init];
        _sectionTitles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_sections release];
    [_sectionTitles release];
    [_categoryId release];
    [_filters release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize sections = _sections, sectionTitles = _sectionTitles;

- (void)insertObject:(Wine *)wine inSectionsAtIndex:(NSUInteger)index
{
    [_sections insertObject:wine atIndex:index];
}

- (void)insertSections:(NSArray *)wines atIndexes:(NSIndexSet *)indexes
{
    [_sections insertObjects:wines atIndexes:indexes];
}

- (void)removeObjectFromSectionsAtIndex:(NSUInteger)index
{
    [_sections removeObjectAtIndex:index];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes
{
    [_sections removeObjectsAtIndexes:indexes];
}

- (void)insertObject:(NSString *)letter inSectionTitlesAtIndex:(NSUInteger)index
{
    [_sectionTitles insertObject:letter atIndex:index];
}

- (void)insertSectionTitles:(NSArray *)letters atIndexes:(NSIndexSet *)indexes
{
    [_sectionTitles insertObjects:letters atIndexes:indexes];
}

- (void)removeObjectFromSectionTitlesAtIndex:(NSUInteger)index
{
    [_sectionTitles removeObjectAtIndex:index];
}

- (void)removeSectionTitlesAtIndexes:(NSIndexSet *)indexes
{
    [_sectionTitles removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark WineCollection (Public)

@synthesize categoryId = _categoryId, filters = _filters;

+ (id)wineCollectionFromDictionary:(NSDictionary *)rawCollection
{
    WineCollection *collection = [[[WineCollection alloc] init] autorelease];
    NSArray *wines;
    UILocalizedIndexedCollation *collation =
            [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *mutableSections =
            [collection mutableArrayValueForKey:kMutableSectionsKey];
    NSMutableArray *mutableSectionTitles =
            [collection mutableArrayValueForKey:kMutableSectionTitlesKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((wines = [rawCollection objectForKey:@"letters"]) == nil)
        return nil;
    if (![wines isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *wineCollection in wines) {
        NSArray *rawWines;
        NSString *sectionTitles;
        
        if  (![wineCollection isKindOfClass:[NSDictionary class]])
            return nil;
        if ((sectionTitles =
                [wineCollection objectForKey:kWineCollectionLetterKey]) == nil)
            return nil;
        if (![sectionTitles isKindOfClass:[NSString class]])
            return nil;
        if ((rawWines =
                [wineCollection objectForKey:kWineCollectionWinesKey]) == nil)
            return nil;
        if (![rawWines isKindOfClass:[NSArray class]])
            return nil;
        
        NSMutableArray *winesInSection =
                [NSMutableArray arrayWithCapacity:[rawWines count]];
        
        [mutableSectionTitles addObject:sectionTitles];
        [collation sectionForObject:sectionTitles
                collationStringSelector:@selector(description)];
        for (NSDictionary *rawWine in rawWines) {
            Wine *wine = [Wine shortWineFromDictionary:rawWine];
            
            if (wine == nil)
                return nil;
            [winesInSection addObject:wine];
        }
        [mutableSections addObject:winesInSection];
    }
    return collection;
}

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [self init]) != nil) {
        _categoryId = [categoryId copy];
    }
    return self;
}

- (id)initWithFilters:(NSString *)filters
{
    if ((self = [self init]) != nil) {
        _filters = [filters copy];
    }
    return self;
}

- (void)copyPropertiesFromWineCollection:(WineCollection *)collection
{
    NSMutableArray *sections =
            [self mutableArrayValueForKey:kMutableSectionsKey];
    NSMutableArray *sectionTitles =
            [self mutableArrayValueForKey:kMutableSectionTitlesKey];

    for (NSString *letter in [collection sectionTitles])
        [sectionTitles addObject:letter];
    for (Wine *wine in [collection sections])
        [sections addObject:wine];
}

- (NSArray *)sectionIndexTitles
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        NSString *url;
        
        if (_categoryId != nil) {
            url = URL(kURLWineCollectionEndPoint, _categoryId);
        } else {
            url = URL(kURLFilterCollectionEndPoint, _filters);
        }
        
        TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
        
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
    WineCollection *wineCollection =
            [WineCollection wineCollectionFromDictionary:rootObject];
    
    if (wineCollection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                          tryAgain:NO];
        return;
    }
    [self copyPropertiesFromWineCollection:wineCollection];
    [super requestDidFinishLoad:request];
}
@end

@implementation Strain

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_strainId release];
    [_name release];
    [_subcategories release];
    [_wines release];
    [super dealloc];
}

#pragma mark -
#pragma mark Strain (Public)

@synthesize  strainId = _strainId, name = _name, subcategories = _subcategories,
        wines = _wines;

+ (id)strainFromDictionary:(NSDictionary *)rawStrain
{
    NSNumber *strainId, *subcategories, *wines;
    NSString *name;
    
    if (![rawStrain isKindOfClass:[NSDictionary class]])
        return nil;
    if ((strainId = [rawStrain objectForKey:kStrainIdKey]) == nil)
        return nil;
    if (![strainId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawStrain objectForKey:kStrainNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((subcategories = [rawStrain objectForKey:kStrainIdKey]) == nil)
        return nil;
    if (![subcategories isKindOfClass:[NSNumber class]])
        return nil;
    if ((wines = [rawStrain objectForKey:kStrainIdKey]) == nil)
        return nil;
    if (![wines isKindOfClass:[NSNumber class]])
        return nil;
    
    Strain *strain = [[[Strain alloc] init] autorelease];
    
    [strain setStrainId:strainId];
    [strain setName:name];
    [strain setSubcategories:subcategories];
    [strain setWines:wines];
    return strain;
}
@end

@implementation StrainCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
            _strains = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_strains release];
    [_recipeId release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize strains = _strains;

- (void)insertObject:(Strain *)strain inStrainsAtIndex:(NSUInteger)index
{
    [_strains insertObject:strain atIndex:index];
}

- (void)insertStrains:(NSArray *)strains atIndexes:(NSIndexSet *)indexes
{
    [_strains insertObjects:strains atIndexes:indexes];
}

- (void)removeObjectFromStrainsAtIndex:(NSUInteger)index
{
    [_strains removeObjectAtIndex:index];
}

- (void)removeStrainsAtIndexes:(NSIndexSet *)indexes
{
    [_strains removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark StrainCollection (Public)

+ (id)strainCollectionFromDictionary:(NSDictionary *)rawCollection
{
    StrainCollection *collection =
            [[[StrainCollection alloc] init] autorelease];
    NSArray *strains;
    NSMutableArray *mutableStrains =
            [collection mutableArrayValueForKey:kMutableStrainsKey];
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((strains =
         [rawCollection objectForKey:kStrainCollectionCategoriesKey]) == nil)
        return nil;
    if (![strains isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawStrain in strains) {
        Strain *strain = [Strain strainFromDictionary:rawStrain];
        
        if (strain == nil)
            return nil;
        [mutableStrains addObject:strain];
    }
    return collection;
}

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [self init]) != nil) {
        _recipeId = [recipeId copy];
    }
    return self;
}

- (void)copyPropertiesFromStrainCollection:(StrainCollection *)collection
{
    NSMutableArray *mutableStrains =
            [self mutableArrayValueForKey:kMutableStrainsKey];
    
    [mutableStrains addObjectsFromArray:[collection strains]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        NSString *url;
        if (_recipeId != nil) {
            url = URL(kURLRecipeStrainCollectionEndPoint, _recipeId);
        } else {
            url = kURLStrainCollectionEndPoint;
        }
        TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
        
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
    StrainCollection *collection =
            [StrainCollection strainCollectionFromDictionary:rootObject];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromStrainCollection:collection];
    [super requestDidFinishLoad:request];
}
@end

@implementation FilterCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _list = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_list release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize list = _list, collectionId = _collectionId;

- (void)insertObject:(id)object inListAtIndex:(NSUInteger)index
{
    [_list insertObject:object atIndex:index];
}

- (void)insertList:(NSArray *)list atIndexes:(NSIndexSet *)indexes
{
    [_list insertObjects:list atIndexes:indexes];
}

- (void)removeObjectFromListAtIndex:(NSUInteger)index
{
    [_list removeObjectAtIndex:index];
}

- (void)removeListAtIndexes:(NSIndexSet *)indexes
{
    [_list removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark FilterCollection (Public)

+ (id)filterCollectionFromDictionary:(NSDictionary *)rawCollection
                        collectionId:(WineFilteringListType)collectionId
{
    FilterCollection *collection = [[[FilterCollection alloc] init]
            autorelease];
    NSArray *list;
    NSMutableArray *mutableList = [collection
            mutableArrayValueForKey:kMutableListKey];
    NSString *key;
    
    switch (collectionId) {
        case kWineCountryFilter:
            key = kFilterCollectionCountriesKey;
            break;
        case kWineWineryFilter:
            key = kFilterCollectionWineriesKey;
            break;
        case kWineStrainFilter:
        case kWineSpaklingWineKindFilter:
            key = kFilterCollectionStrainsKey;
            break;
        default:
            break;
    }
    
    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((list = [rawCollection objectForKey:key]) == nil)
        return nil;
    if (![list isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawItem in list) {
        Country *item = [Country countryFromDictionary:rawItem];
        
        if (item == nil)
            return nil;
        [mutableList addObject:item];
    }
    return collection;
    return nil;
}

- (id)initWithCollectionId:(WineFilteringListType)collectionId
{
    if ((self = [self init]) != nil) {
        _collectionId = collectionId;
    }
    return self;
}

- (void)copyPropertiesFromFilterCollection:(FilterCollection *)collection
{
    NSMutableArray *mutableList =
            [self mutableArrayValueForKey:kMutableListKey];
    
    [mutableList addObjectsFromArray:[collection list]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        NSString *url;
        
        switch (_collectionId) {
            case kWineCountryFilter:
                url = kURLCountriesCollectionEndPoint;
                break;
            case kWineWineryFilter:
                url = kURLWineriesCollectionEndPoint;
                break;
            case kWineStrainFilter:
                url = kURLStrainsCollectionEndPoint;
                break;
            case kWineSpaklingWineKindFilter:
                url = kURLSparklingWineKindCollectionEndPoint;
                break;
            default:
                break;
        }
        
        TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
        
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
    FilterCollection *collection = [FilterCollection
            filterCollectionFromDictionary:rootObject
                collectionId:_collectionId];
    
    if (collection == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromFilterCollection:collection];
    [super requestDidFinishLoad:request];
}
@end

@implementation WineLargeImage

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark WineLargeImage

@synthesize caption = _caption, size = _size, photoSource = _photoSource,
        index = _index, url = _url;

- (id)initWithPictureURL:(NSString *)pictureURL
{
    if ((self = [super init]) != nil) {
        _url = pictureURL;
        _caption = @"";
        _size = CGSizeMake(320., 480.);
        _photoSource = nil;
        _index = 0;
    }
    return self;
}

#pragma mark -
#pragma mark <TTPhoto>

- (NSString *)URLForVersion:(TTPhotoVersion)version
{
    return _url;
}

@end