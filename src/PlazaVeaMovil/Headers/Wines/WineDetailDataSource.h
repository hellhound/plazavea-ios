#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol WineDetailDataSourceDelegate;

@interface WineDetailDataSource: TTSectionedDataSource
{
    id<WineDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate;
@end

@protocol WineDetailDataSourceDelegate <NSObject>

- (void)        dataSource:(WineDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                  andTitle:(NSString *)title;
@end