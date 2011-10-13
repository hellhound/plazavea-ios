#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

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
