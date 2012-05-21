#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/Constants.h"

@protocol LocalFilteringListControllerDelegate;

@interface LocalFilteringListController: UITableViewController
{
    WineLocalFilteringListType _list;
    id<LocalFilteringListControllerDelegate> _delegate;
}
@property (nonatomic, assign) WineLocalFilteringListType list;
@property (nonatomic, assign) id<LocalFilteringListControllerDelegate> delegate;

- (id)initWithList:(WineLocalFilteringListType)list;
- (id)initWithList:(WineLocalFilteringListType)list
          delegate:(id<LocalFilteringListControllerDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@protocol LocalFilteringListControllerDelegate <NSObject>

/*- (void)controller:(LocalFilteringListController *)controller
            itemId:(NSNumber *)itemId;*/
- (void)controller:(LocalFilteringListController *)controller
didPickLocalItemId:(int)itemId;
@end
