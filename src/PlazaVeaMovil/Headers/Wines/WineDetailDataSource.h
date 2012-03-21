#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@protocol WineDetailDataSourceDelegate;

@interface WineDetailDataSource: TTListDataSource
{
    id<WineDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineDetailDataSourceDelegate <NSObject>

- (void)dataSource:(WineDetailDataSource *)dataSource
    viewForHeader:(UIView *)view;
- (void)dataSource:(WineDetailDataSource *)dataSource wineName:(NSString *)name;
- (void)dataSource:(WineDetailDataSource *)dataSource
      wineImageURL:(NSString *)imageURL;
@end