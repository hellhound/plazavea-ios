#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Offers/Models.h"

static NSString *const kURLOfferEndPoint = @"";

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

+ (id)bannerFromDictionary:(NSDictionary *)rawBanner
{
    NSString *pictureURL;
    NSDate *start, *end;
    
    if (![rawBanner isKindOfClass:[NSDictionary class]])
        return nil;
    if ((pictureURL = [rawBanner objectForKey:@"picture"]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]])
        return nil;
    if ((start = [rawBanner objectForKey:@"start"]) == nil)
        return nil;
    if (![start isKindOfClass:[NSDate class]])
        return nil;
    if ((end = [rawBanner objectForKey:@"end"]) == nil)
        return nil;
    if (![end isKindOfClass:[NSDate class]])
        return nil;
    
    Banner *banner = [[[Banner alloc] init] autorelease];
    
    [banner setPictureURL:pictureURL];
    [banner setStart:start];
    [banner setEnd:end];
    return banner;
}
@end

@implementation Offer

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_offerId release];
    [_code release];
    [_name release];
    [_description release];
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
#pragma mark Offer (Public)

@synthesize offerId = _offerId, code = _code, name = _name,
        description = _description, price = _price, oldPrice = _oldPrice,
            discount = _discount, validFrom = _validFrom, validTo = _validTo,
            pictureURL = _pictureURL, extraPictureURLs = _extraPicturesURLs,
            facebookURL = _facebookURL, twitterURL = _twitterURL;
            

+ (id)shortOfferFromDictionary:(NSDictionary *)rawOffer
{
    NSNumber *offerId, *price;
    NSString *code, *name;
    NSURL *pictureURL;
    
    if (![rawOffer isKindOfClass:[NSDictionary class]])
        return nil;
    if ((offerId = [rawOffer objectForKey:@"id"]) == nil)
        return nil;
    if (![offerId isKindOfClass:[NSNumber class]])
        return nil;
    if ((code = [rawOffer objectForKey:@"code"]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((name = [rawOffer objectForKey:@"name"]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((price = [rawOffer objectForKey:@"price"]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]])
        return nil;
    if ((pictureURL = [rawOffer objectForKey:@"picture"]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSURL class]])
        return nil;
    
    Offer *offer = [[[Offer alloc] init] autorelease];
    
    [offer setOfferId:offerId];
    [offer setCode:code];
    [offer setName:name];
    [offer setPrice:price];
    [offer setPictureURL:pictureURL];
    return offer;
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

@synthesize offers = _offers;

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
        TTURLRequest *request = [TTURLRequest requestWithURL:kURLOfferEndPoint
                delegate:self];
        
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request setCachePolicy:cachePolicy];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidStartLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject = [(TTURLJSONResponse *)[request response]
            rootObject];
    NSArray *rawOffers;
    NSMutableArray *mutableOffers = [self mutableArrayValueForKey:@"offers"];
    
    if (![rootObject isKindOfClass:[NSDictionary class]])
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    if ((rawOffers = [rootObject objectForKey:@"offers"]) == nil)
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    if (![rawOffers isKindOfClass:[NSArray class]])
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    for (NSDictionary *rawOffer in rawOffers) {
        Offer *offer = [Offer shortOfferFromDictionary:rawOffer];
        
        if (offer == nil)
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
            return;
        [mutableOffers addObject:offer];
    }
    [super requestDidStartLoad:request];
}

@end