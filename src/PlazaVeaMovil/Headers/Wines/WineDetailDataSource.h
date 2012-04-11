#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"

@protocol WineDetailDataSourceDelegate;

@interface WineDetailDataSource: TTListDataSource
{
    WineDetailFromType _from;
    id<WineDetailDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) WineDetailFromType from;
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate
                from:(WineDetailFromType)from;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineDetailDataSourceDelegate <NSObject>

- (void)dataSource:(WineDetailDataSource *)dataSource
    viewForHeader:(UIView *)view;
- (void)dataSource:(WineDetailDataSource *)dataSource wineName:(NSString *)name;
- (void)dataSource:(WineDetailDataSource *)dataSource
      wineImageURL:(NSString *)imageURL;
@end