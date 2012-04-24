#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@protocol WineTasteDataSourceDelegate;

@interface WineTasteDataSource: TTListDataSource <TTImageViewDelegate>
{
    id<WineTasteDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineTasteDataSourceDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineTasteDataSourceDelegate <NSObject>

- (void) dataSource:(WineTasteDataSource *)dataSource
      viewForHeader:(UIView *)view;
@end