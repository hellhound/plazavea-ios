#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Stores/Models.h"

@interface StoreListDataSource: TTSectionedDataSource

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId;
@end