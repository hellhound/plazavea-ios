#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"

// Offer collection's key pathes
static NSString *const kMutableOffersKey = @"offers";
// Promotion KVC key's constants
static NSString *const kMutableExtraPictureURLsKey = @"extraPictureURLs";
// PromotionCollection KVC key's constants
static NSString *const kMutablePromotionsKey = @"promotions";

@implementation Banner

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_pictureURL release];
    [_start release];
    [_end release];
    [super dealloc];
}

#pragma mark -
#pragma mark Banner (Public)

@synthesize pictureURL = _pictureURL, start = _start, end = _end;

+ (id)bannerFromDictionary:(id)rawBanner
{
    NSString *pictureURL;
    if (![rawBanner isKindOfClass:[NSDictionary class]])
        return nil;
    if ((pictureURL =
            [rawBanner objectForKey:kBannerPictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }
    
    Banner *banner = [[[Banner alloc] init] autorelease];
    
    [banner setPictureURL:[NSURL URLWithString:pictureURL]];
    return banner;
}
@end

@implementation Offer

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        _extraPicturesURLs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_offerId release];
    [_code release];
    [_name release];
    [_longDescription release];
    [_price release];
    [_oldPrice release];
    [_discount release];
    [_validFrom release];
    [_validTo release];
    [_pictureURL release];
    [_extraPicturesURLs release];
    [_facebookURL release];
    [_twitterURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize extraPictureURLs = _extraPicturesURLs;

- (void)        insertObject:(NSURL *)extraURL 
   inExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPicturesURLs insertObject:extraURL atIndex:index];
}

- (void)insertExtraPictureURLs:(NSArray *)extraURLs
                     atIndexes:(NSIndexSet *)indexes
{
    [_extraPicturesURLs removeObjectsAtIndexes:indexes];
}

- (void)removeObjectFromExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPicturesURLs removeObjectAtIndex:index];
}

- (void)removeExtraPictureURLsAtIndexes:(NSIndexSet *)indexes
{
    [_extraPicturesURLs removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark Offer (Public)

@synthesize offerId = _offerId, code = _code, name = _name,
        longDescription = _longDescription, price = _price,
            oldPrice = _oldPrice, discount = _discount, validFrom = _validFrom,
            validTo = _validTo, pictureURL = _pictureURL,
            facebookURL = _facebookURL, twitterURL = _twitterURL;
            

+ (id)shortOfferFromDictionary:(NSDictionary *)rawOffer
{
    NSNumber *offerId, *price;
    NSString *code, *name, *pictureURL;
    
    if (![rawOffer isKindOfClass:[NSDictionary class]])
        return nil;
    if ((offerId = [rawOffer objectForKey:kOfferIdKey]) == nil)
        return nil;
    if (![offerId isKindOfClass:[NSNumber class]])
        return nil;
    if ((code = [rawOffer objectForKey:kOfferCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]]) {
        if (![code isKindOfClass:[NSNull class]])
            return nil;
        code = nil;
    }
    if ((name = [rawOffer objectForKey:kOfferNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((price = [rawOffer objectForKey:kOfferPriceKey]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]])
        return nil;
    if ((pictureURL = [rawOffer objectForKey:kOfferPictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }
    
    Offer *offer = [[[Offer alloc] init] autorelease];
    
    [offer setOfferId:offerId];
    [offer setCode:code];
    [offer setName:name];
    [offer setPrice:price];
    [offer setPictureURL:[NSURL URLWithString:pictureURL]];
    return offer;
}

+ (id)offerFromDictionary:(NSDictionary *)rawOffer
{
    Offer *offer = [self shortOfferFromDictionary:rawOffer];

    if (offer == nil)
        return nil;
    
    NSString *longDescription, *discount, *facebookURL, *twitterURL;
    NSNumber *oldPrice;
    NSArray *extraPictureURLs;
    NSMutableArray *mutableExtraPictureURLs =
            [offer mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    
    if ((longDescription = [rawOffer objectForKey:kOfferDescriptionKey]) == nil)
        return nil;
    if (![longDescription isKindOfClass:[NSString class]])
        return nil;
    if ((oldPrice = [rawOffer objectForKey:kOfferOldPriceKey]) == nil)
        return  nil;
    if (![oldPrice isKindOfClass:[NSNumber class]]) {
        if (![oldPrice isKindOfClass:[NSNull class]])
            return nil;
        oldPrice = nil;
    }
    if ((discount = [rawOffer objectForKey:kOfferDiscountKey]) == nil)
        return nil;
    if (![discount isKindOfClass:[NSString class]]) {
        if (![discount isKindOfClass:[NSNull class]])
            return nil;
        discount = nil;
    }
    if ((extraPictureURLs =
            [rawOffer objectForKey:kOfferExtraPictureURLsKey]) == nil)
        return nil;
    if (![extraPictureURLs isKindOfClass:[NSArray class]])
        return nil;
    if ((facebookURL = [rawOffer objectForKey:kOfferFacebookURLKey]) == nil)
        return nil;
    if (![facebookURL isKindOfClass:[NSString class]]) {
        if (![facebookURL isKindOfClass:[NSNull class]])
            return nil;
        facebookURL = nil;
    }
    if ((twitterURL = [rawOffer objectForKey:kOfferTwitterURLKey]) == nil)
        return nil;
    if (![twitterURL isKindOfClass:[NSString class]]) {
        if (![twitterURL isKindOfClass:[NSNull class]])
            return nil;
        twitterURL = nil;
    }
    [offer setLongDescription:longDescription];
    [offer setOldPrice:oldPrice];
    [offer setDiscount:discount];
    [offer setFacebookURL:[NSURL URLWithString:facebookURL]];
    [offer setTwitterURL:[NSURL URLWithString:twitterURL]];
    for (NSString *extraPictureURL in extraPictureURLs) {
        if (![extraPictureURL isKindOfClass:[NSString class]])
            return nil;
        [mutableExtraPictureURLs addObject:
                [NSURL URLWithString:extraPictureURL]];
    }
    return offer;
}

- (id)initWithOfferId:(NSString *)offerId
{
    NSInteger offerIntegerId = [offerId integerValue];
    if (offerIntegerId < 0) {
        return nil;
    }
    if ((self = [self init]) != nil)
        [self setOfferId:[NSNumber numberWithInteger:offerIntegerId]];
    return self;
}

- (void)copyPropertiesFromOffer:(Offer *)offer
{
    [self setOfferId:[offer offerId]];
    [self setCode:[[offer code] copy]];
    [self setName:[[offer name] copy]];
    [self setLongDescription:[[offer longDescription] copy]];
    [self setPrice:[offer price]];
    [self setOldPrice:[offer oldPrice]];
    [self setDiscount:[[offer discount] copy]];
    [self setPictureURL:[offer pictureURL]];
    [self setFacebookURL:[offer facebookURL]];
    [self setTwitterURL:[offer twitterURL]];
    
    NSMutableArray *extraPictureURLs =
            [self mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    
    for (NSURL *extraPictureURL in [offer extraPictureURLs])
        [extraPictureURLs addObject:extraPictureURL];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kURLOfferDetailEndpoint, _offerId) delegate:self];

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
    Offer *offer = [Offer offerFromDictionary:rootObject];
    
    if (offer == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromOffer:offer];
    [super requestDidFinishLoad:request];
}
@end

@implementation OfferCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _offers = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_offers release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize offers = _offers, banner = _banner;

- (void)insertObject:(Offer *)offer inOffersAtIndex:(NSUInteger)index
{
    [_offers insertObject:offer atIndex:index];
}

- (void)insertOffers:(NSArray *)array atIndexes:(NSIndexSet *)indexes
{
    [_offers insertObjects:array atIndexes:indexes];
}

- (void)removeObjectFromOffersAtIndex:(NSUInteger)index
{
    [_offers removeObjectAtIndex:index];
}

- (void)removeOffersAtIndexes:(NSIndexSet *)indexes
{
    [_offers removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request =
                [TTURLRequest requestWithURL:kURLOfferListEndpoint
                    delegate:self];
        
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
    NSArray *rawOffers;
    NSMutableArray *mutableOffers =
            [self mutableArrayValueForKey:kMutableOffersKey];
    
    if (![rootObject isKindOfClass:[NSDictionary class]]) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    if ((rawOffers = [rootObject objectForKey:kOfferCollectionOffersKey])
        == nil) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    if (![rawOffers isKindOfClass:[NSArray class]]) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    for (NSDictionary *rawOffer in rawOffers) {
        Offer *offer = [Offer shortOfferFromDictionary:rawOffer];
        
        if (offer == nil) {
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
            return;
        }
        [mutableOffers addObject:offer];
    }
 
    Banner *banner = [Banner bannerFromDictionary:
                [rootObject objectForKey:kOfferCollectionBannerKey]];

    [self setBanner:banner];
    [super requestDidFinishLoad:request];
}

@end

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
    [self shortPromotionFromDictionary:rawPromotion];
    NSMutableArray *mutableExtraPictureURLs =
    [promotion mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    
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
    if ((twitterURL = [rawPromotion objectForKey:kPromotionTwitterURLKey])
        == nil)
        return nil;
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

- (id)initWithPromotionId:(NSString *)promotionId
{
    NSInteger promotionIntegerId = [promotionId integerValue];
    if (promotionIntegerId < 0) {
        return nil;
    }
    if ((self = [self init]) != nil)
        [self setPromotionId:[NSNumber numberWithInteger:promotionIntegerId]];
    return self;
}

- (void)copyPropertiesFromPromotion:(Promotion *)promotion
{
    NSMutableArray *mutableExtraPictureURLs =
            [self mutableArrayValueForKey:kMutableExtraPictureURLsKey];

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

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kURLPromotionDetailEndPoint, _promotionId) delegate:self];
        
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
    Promotion *promotion = [Promotion promotionFromDictionary:rootObject];
    
    if (promotion == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
        return;
    }
    [self copyPropertiesFromPromotion:promotion];
    [super requestDidFinishLoad:request];
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
            [collection mutableArrayValueForKey:kMutablePromotionsKey];

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
            [self mutableArrayValueForKey:kMutablePromotionsKey];

    [mutablePromotions addObjectsFromArray:[collection promotions]];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest
                requestWithURL:kPromotionListEndpoint delegate:self];

        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
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
