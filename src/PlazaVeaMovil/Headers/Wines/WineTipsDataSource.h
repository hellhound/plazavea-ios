#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@protocol WineTipsDataSourceDelegate;

@interface WineTipsDataSource: TTListDataSource
{
    id<WineTipsDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineTipsDataSourceDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineTipsDataSourceDelegate <NSObject>

- (void) dataSource:(WineTipsDataSource *)dataSource
      viewForHeader:(UIView *)view;
@end