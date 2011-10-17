#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

@interface Banner: NSObject
{
    NSURL *_pictureURL;
    NSDate *_start;
    NSDate *_end;
}
@property (nonatomic, copy) NSURL *pictureURL;
@property (nonatomic, retain) NSDate *start;
@property (nonatomic, retain) NSDate *end;

+ (id)bannerFromDictionary:(NSDictionary *)rawBanner;
@end

@interface Offer: URLRequestModel
{
    NSNumber *_offerId;
    NSString *_code;
    NSString *_name;
    NSString *_longDescription;
    NSNumber *_price;
    NSNumber *_oldPrice;
    NSString *_discount;
    NSDate *_validFrom;
    NSDate *_validTo;
    NSURL *_pictureURL;
    NSMutableArray *_extraPicturesURLs;
    NSURL *_facebookURL;
    NSURL *_twitterURL;
}
@property (nonatomic, retain) NSNumber *offerId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *longDescription;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *oldPrice;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, retain) NSDate *validFrom;
@property (nonatomic, retain) NSDate *validTo;
@property (nonatomic, retain) NSURL *pictureURL;
@property (nonatomic, readonly) NSArray *extraPictureURLs;
@property (nonatomic, retain) NSURL *facebookURL;
@property (nonatomic, retain) NSURL *twitterURL;

+ (id)shortOfferFromDictionary:(NSDictionary *)rawOffer;
+ (id)offerFromDictionary:(NSDictionary *)rawOffer;

- (id)initWithOfferId:(NSString *)offerId;
- (void)copyPropertiesFromOffer:(Offer *)offer;
@end

@interface OfferCollection: URLRequestModel
{
    Banner *_banner;
    NSMutableArray *_offers;
}
@property (nonatomic, retain) Banner *banner;
@property (nonatomic, readonly) NSMutableArray *offers;

@end

@interface Promotion: URLRequestModel
{
    NSNumber *_promotionId;
    NSString *_code;
    NSString *_name;
    NSURL *_bannerURL;
    NSString *_longDescription;
    NSString *_legalese;
    NSString *_validFrom;
    NSString *_validTo;
    NSMutableArray *_extraPictureURLs;
    NSURL *_facebookURL;
    NSURL *_twitterURL;
}
@property (nonatomic, retain) NSNumber *promotionId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSURL *bannerURL;
@property (nonatomic, copy) NSString *longDescription;
@property (nonatomic, copy) NSString *legalese;
@property (nonatomic, copy) NSString *validFrom;
@property (nonatomic, copy) NSString *validTo;
@property (nonatomic, readonly) NSArray *extraPictureURLs;
@property (nonatomic, retain) NSURL *facebookURL;
@property (nonatomic, retain) NSURL *twitterURL;

+ (id)shortPromotionFromDictionary:(NSDictionary *)rawPromotion;
+ (id)promotionFromDictionary:(NSDictionary *)rawPromotion;

- (id)initWithPromotionId:(NSString *)promotionId;
- (void)copyPropertiesFromPromotion:(Promotion *)promotion;
@end

@interface PromotionCollection: URLRequestModel
{
    NSMutableArray *_promotions;
}
@property (nonatomic, readonly) NSArray *promotions;

+ (id)promotionCollectionFromDictionary:(NSDictionary *)rawCollection;

- (void)copyPropertiesFromPromotionCollection:(PromotionCollection *)collection;
@end
