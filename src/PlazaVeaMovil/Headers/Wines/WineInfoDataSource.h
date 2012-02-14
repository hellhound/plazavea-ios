#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@protocol WineInfoDataSourceDelegate;

@interface WineInfoDataSource: TTListDataSource
{
    id<WineInfoDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineInfoDataSourceDelegate>)delegate;

@end

@protocol WineInfoDataSourceDelegate <NSObject>

- (void)dataSource:(WineInfoDataSource *)dataSource
     viewForHeader:(UIView *)view;
@end