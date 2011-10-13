#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

@interface Banner : NSObject
{
    NSString *_pictureURL;
    NSDate *_start;
    NSDate *_end;
}
@property (nonatomic, copy) NSString *pictureURL;
@property (nonatomic, retain) NSDate *start;
@property (nonatomic, retain) NSDate *end;

+ (id)bannerFromDictionary:(NSDictionary *)rawBanner;
@end

@interface Offer : NSObject
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
@end

@interface OfferCollection : URLRequestModel
{
    Banner *_banner;
    NSMutableArray *_offers;
}
@property (nonatomic, retain) Banner *banner;
@property (nonatomic, readonly) NSMutableArray *offers;

@end
