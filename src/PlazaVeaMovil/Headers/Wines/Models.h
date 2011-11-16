#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Common/Models/URLRequestModel.h"

@interface Country: NSObject
{
    NSNumber *_countryId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *countryId;
@property (nonatomic, copy) NSString *name;

+ (id)countryFromDictionary:(NSDictionary *)rawData;
@end

@interface WineRegion: NSObject
{
    NSNumber *_regionId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *regionId;
@property (nonatomic, copy) NSString *name;

+ (id)regionFromDictionary:(NSDictionary *)rawData;
@end

@interface Brand: NSObject
{
    NSNumber *_brandId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *brandId;
@property (nonatomic, copy) NSString *name;

+ (id)brandFromDictionary:(NSDictionary *)rawData;
@end

@interface Kind: NSObject
{
    NSNumber *_kindId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *kindId;
@property (nonatomic, copy) NSString *name;

+ (id)kindFromDictionary:(NSDictionary *)rawData;
@end

@interface Winery: NSObject
{
    NSNumber *_wineryId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *wineryId;
@property (nonatomic, copy) NSString *name;

+ (id)wineryFromDictionary:(NSDictionary *)rawData;
@end

@interface Wine: URLRequestModel
{
    NSNumber *_wineId;
    NSString *_code;
    NSString *_name;
    NSNumber *_milliliters;
    NSURL *_pictureURL;
    NSMutableArray *_extraPictureURLs;
    NSNumber *_price;
    NSNumber *_harvestYear;
    NSString *_barrel;
    NSString *_look;
    NSString *_taste;
    NSString *_smell;
    NSNumber *_temperature;
    NSNumber *_cellaring;
    NSNumber *_oxygenation;
    Country *_country;
    WineRegion *_region;
    Brand *_brand;
    Kind *_kind;
    Winery *_winery;
}
@property (nonatomic, retain) NSNumber *wineId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *milliliters;
@property (nonatomic, retain) NSURL *pictureURL;
@property (nonatomic, readonly) NSArray *extraPictureURLs;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *harvestYear;
@property (nonatomic, copy) NSString *barrel;
@property (nonatomic, copy) NSString *look;
@property (nonatomic, copy) NSString *taste;
@property (nonatomic, copy) NSString *smell;
@property (nonatomic, retain) NSNumber *temperature;
@property (nonatomic, retain) NSNumber *cellaring;
@property (nonatomic, retain) NSNumber *oxygenation;
@property (nonatomic, retain) Country *country;
@property (nonatomic, retain) WineRegion *region;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) Kind *kind;
@property (nonatomic, retain) Winery *winery;

+ (id)shortWineFromDictionary:(NSDictionary *)rawWine;
+ (id)wineFromDictionary:(NSDictionary *)rawWine;

- (id)initWithWineId:(NSString *)wineId;
- (void)copyPropertiesFromWine:(Wine *)wine;
@end

@interface WineCollection: URLRequestModel
{
    NSString *_categoryId;
    NSMutableArray *_sections;
    NSMutableArray *_sectionTitles;
}
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, readonly) NSArray *sections;
@property (nonatomic, readonly) NSArray *sectionTitles;

+ (id)wineCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithCategoryId:(NSString *)categoryId;
- (void)copyPropertiesFromWineCollection:(WineCollection *)collection;
- (NSArray *)sectionIndexTitles;
@end

@interface Strain: NSObject
{
    NSNumber *_strainId;
    NSString *_name;
    NSNumber *_subcategories;
    NSNumber *_wines;
}
@property (nonatomic, retain) NSNumber *strainId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *subcategories;
@property (nonatomic, retain) NSNumber *wines;

+ (id)strainFromDictionary:(NSDictionary *)rawStrain;
@end

@interface StrainCollection: URLRequestModel
{
    NSMutableArray *_strains;
    NSString *_recipeId;
}
@property (nonatomic, readonly) NSArray *strains;

+ (id)strainCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithRecipeId:(NSString *)recipeId;
- (void)copyPropertiesFromStrainCollection:(StrainCollection *)collection;
@end
