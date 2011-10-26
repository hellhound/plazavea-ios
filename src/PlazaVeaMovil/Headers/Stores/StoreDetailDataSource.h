#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
@protocol StoreDetailDataSourceDelegate;

@interface StoreDetailDataSource: TTSectionedDataSource
{
    id<StoreDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithStoreId:(NSString *)storeId
              delegate:(id<StoreDetailDataSourceDelegate>)delegate;
@end

@protocol StoreDetailDataSourceDelegate <NSObject>
@end

