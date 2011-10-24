#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface StoreListDataSource: TTSectionedDataSource

- (id)initWithSubregionId:(NSString *)subregionId
                andRegionId:(NSString *)regionId;
@end