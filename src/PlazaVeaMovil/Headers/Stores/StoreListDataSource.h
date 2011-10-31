#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Stores/Models.h"

@protocol StoreListDataSourceDelegate;

@interface StoreListDataSource: TTSectionedDataSource
{
    id<StoreListDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
                 delegate:(id<StoreListDataSourceDelegate>)delegate;

@end

@protocol StoreListDataSourceDelegate <NSObject>
- (void)    dataSource:(StoreListDataSource *)dataSource
  needsStoreCollection:(NSArray *)stores;
@end