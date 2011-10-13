#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"

// Promotion KVC key's constants
static NSString *const kExtraPictureURLsKey = @"extraPictureURLs";
// PromotionCollection KVC key's constants
static NSString *const kPromotionsKey = @"promotions";

@implementation Promotion

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
    [_promotionId release];
    [_code release];
    [_name release];
    [_bannerURL release];
    [_longDescription release];
    [_legalese release];
    [_validFrom release];
    [_validTo release];
    [_extraPictureURLs release];
    [_facebookURL release];
    [_twitterURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize extraPictureURLs = _extraPictureURLs;

- (void)        insertObject:(NSString *)extraPictureURL
   inExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPictureURLs insertObject:extraPictureURL atIndex:index];
}

- (void)insertExtraPictureURLs:(NSArray *)extraPictureURLs
                     atIndexes:(NSIndexSet *)indexes
{
    [_extraPictureURLs insertObjects:extraPictureURLs atIndexes:indexes];
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
#pragma mark Promotion (Public)

@synthesize promotionId = _promotionId, code = _code, name = _name,
    bannerURL = _bannerURL, longDescription = _longDescription,
    legalese = _legalese, validFrom = _validFrom, validTo = _validTo,
    facebookURL = _facebookURL, twitterURL = _twitterURL;

+ (id)shortPromotionFromDictionary:(NSDictionary *)rawPromotion
{
    NSNumber *promotionId;
    NSString *code, *name, *bannerURL;

    if (![rawPromotion isKindOfClass:[NSDictionary class]])
        return nil;
    if ((promotionId = [rawPromotion objectForKey:kPromotionIdKey]) == nil)
        return nil;
    if (![promotionId isKindOfClass:[NSNumber class]])
        return nil;
    if ((code = [rawPromotion objectForKey:kPromotionCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((name = [rawPromotion objectForKey:kPromotionNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((bannerURL = [rawPromotion objectForKey:kPromotionBannerURLKey]) == nil)
        return nil;
    if (![bannerURL isKindOfClass:[NSString class]]) {
        if (![bannerURL isKindOfClass:[NSNull class]])
            return nil;
        bannerURL = nil;
    }

    Promotion *promotion = [[[Promotion alloc] init] autorelease];

    [promotion setPromotionId:promotionId];
    [promotion setCode:code];
    [promotion setName:name];
    [promotion setBannerURL:[NSURL URLWithString:bannerURL]];
    return promotion;
}

+ (id)promotionFromDictionary:(NSDictionary *)rawPromotion
{
    NSString *description, *legalese;
    NSString *validFrom, *validTo;
    NSArray *extraPictureURLs;
    NSString *facebookURL, *twitterURL;
    Promotion *promotion =
            [Promotion shortPromotionFromDictionary:rawPromotion];
    NSMutableArray *mutableExtraPictureURLs =
            [promotion mutableArrayValueForKey:kExtraPictureURLsKey];

    if (promotion == nil)
        return nil;

    if ((description =
            [rawPromotion objectForKey:kPromotionDescriptionKey]) == nil)
        return nil;
    if (![description isKindOfClass:[NSString class]])
        return nil;
    if ((legalese = [rawPromotion objectForKey:kPromotionLegaleseKey]) == nil)
        return nil;
    if (![legalese isKindOfClass:[NSString class]])
        return nil;
    if ((validFrom = [rawPromotion objectForKey:kPromotionValidFromKey]) == nil)
        return nil;
    if (![validFrom isKindOfClass:[NSString class]])
        return nil;
    if ((validTo = [rawPromotion objectForKey:kPromotionValidToKey]) == nil)
        return nil;
    if (![validTo isKindOfClass:[NSString class]])
        return nil;
    if ((extraPictureURLs =
            [rawPromotion objectForKey:kPromotionExtraPictureURLsKey]) == nil)
        return nil;
    if (![extraPictureURLs isKindOfClass:[NSArray class]])
        return nil;
    if ((facebookURL =
            [rawPromotion objectForKey:kPromotionFacebookURLKey]) == nil)
        return nil;
    if (![facebookURL isKindOfClass:[NSString class]]) {
        if (![facebookURL isKindOfClass:[NSNull class]])
            return nil;
        facebookURL = nil;
    }
    if (![twitterURL isKindOfClass:[NSString class]]) {
        if (![twitterURL isKindOfClass:[NSNull class]])
            return nil;
        twitterURL = nil;
    }
    [promotion setLongDescription:description];
    [promotion setLegalese:legalese];
    [promotion setValidFrom:validFrom];
    [promotion setValidTo:validTo];
    [mutableExtraPictureURLs addObjectsFromArray:extraPictureURLs];
    [promotion setFacebookURL:[NSURL URLWithString:facebookURL]];
    [promotion setTwitterURL:[NSURL URLWithString:twitterURL]];
    return promotion;
}

- (void)copyPropertiesFromPromotion:(Promotion *)promotion
{
    NSMutableArray *mutableExtraPictureURLs =
            [self mutableArrayValueForKey:kExtraPictureURLsKey];

    [self setPromotionId:[promotion promotionId]];
    [self setCode:[promotion code]];
    [self setName:[promotion name]];
    [self setBannerURL:[promotion bannerURL]];
    [self setLongDescription:[promotion longDescription]];
    [self setLegalese:[promotion legalese]];
    [self setValidFrom:[promotion validFrom]];
    [self setValidTo:[promotion validTo]];
    [mutableExtraPictureURLs addObjectsFromArray:[promotion extraPictureURLs]];
    [self setFacebookURL:[promotion facebookURL]];
    [self setTwitterURL:[promotion twitterURL]];
}
@end

@implementation PromotionCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _promotions = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_promotions release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize promotions = _promotions;

- (void)insertObject:(Promotion *)promotion
 inPromotionsAtIndex:(NSUInteger)index
{
    [_promotions insertObject:promotion atIndex:index];
}

- (void)insertPromotions:(NSArray *)promotions
               atIndexes:(NSIndexSet *)indexes
{
    [_promotions insertObjects:promotions atIndexes:indexes];
}

- (void)removeObjectFromPromotionsAtIndex:(NSUInteger)index
{
    [_promotions removeObjectAtIndex:index];
}

- (void)removePromotionsAtIndexes:(NSIndexSet *)indexes
{
    [_promotions removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark PromotionCollection (Public)

+ (id)promotionCollectionFromDictionary:(NSDictionary *)rawCollection
{
    PromotionCollection *collection =
            [[[PromotionCollection alloc] init] autorelease];
    NSArray *promotions;
    NSMutableArray *mutablePromotions =
            [collection mutableArrayValueForKey:kPromotionsKey];

    if (![rawCollection isKindOfClass:[NSDictionary class]])
        return nil;
    if ((promotions =
            [rawCollection objectForKey:kPromotionCollectionPromotions]) == nil)
        return nil;
    if (![promotions isKindOfClass:[NSArray class]])
        return nil;
    for (NSDictionary *rawPromotion in promotions) {
        Promotion *promotion =
                [Promotion shortPromotionFromDictionary:rawPromotion];

        if (promotion == nil)
            return nil;
        [mutablePromotions addObject:promotion];
    }
    return collection;
}

- (void)copyPropertiesFromPromotionCollection:(PromotionCollection *)collection
{
    NSMutableArray *mutablePromotions =
            [self mutableArrayValueForKey:kPromotionsKey];

    [mutablePromotions addObjectsFromArray:[self promotions]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest
                requestWithURL:kPromotionListEndpoint delegate:self];

        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request setCachePolicy:cachePolicy];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    TTURLJSONResponse *response = [request response];
    NSDictionary *rootObject = [response rootObject];
    PromotionCollection *collection =
            [PromotionCollection promotionCollectionFromDictionary:rootObject];

    if (collection == nil) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    [self copyPropertiesFromPromotionCollection:collection];
    [super requestDidFinishLoad:request];
}
@end
