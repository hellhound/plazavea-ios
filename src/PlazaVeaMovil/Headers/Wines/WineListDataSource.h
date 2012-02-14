#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@protocol WineListDataSourceDelegate;

@interface WineListDataSource: TTSectionedDataSource
{
    id<WineListDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithCategoryId:(NSString *)categoryId
                delegate:(id<WineListDataSourceDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineListDataSourceDelegate <NSObject>

- (void)dataSource:(WineListDataSource *)dataSource
     viewForHeader:(UIView *)view;
@end