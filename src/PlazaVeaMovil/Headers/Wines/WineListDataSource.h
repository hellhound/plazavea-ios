#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"

@protocol WineListDataSourceDelegate;

@interface WineListDataSource: TTSectionedDataSource
{
    NSString *_from;
    id<WineListDataSourceDelegate> _delegate;
}
@property (nonatomic, retain) NSString *from;
@property (nonatomic, assign) id delegate;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithCategoryId:(NSString *)categoryId
                delegate:(id<WineListDataSourceDelegate>)delegate;
- (id)initWithCategoryId:(NSString *)categoryId
                delegate:(id<WineListDataSourceDelegate>)delegate
                    from:(WineDetailFromType)from;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol WineListDataSourceDelegate <NSObject>

- (void)dataSource:(WineListDataSource *)dataSource
     viewForHeader:(UIView *)view;
@end