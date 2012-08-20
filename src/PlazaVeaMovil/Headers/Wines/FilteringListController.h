#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Wines/Constants.h"

@protocol FilteringListControllerDelegate;

@interface FilteringListController: ReconnectableTableViewController
{
    WineFilteringListType _list;
    id<FilteringListControllerDelegate> _delegate;
}
@property (nonatomic, assign) WineFilteringListType list;
@property (nonatomic, assign) id<FilteringListControllerDelegate> delegate;

- (id)initWithList:(NSString *)list;
- (id)initWithList:(NSString *)list
          delegate:(id<FilteringListControllerDelegate>)delegate;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
- (void)back:(id)sender;
@end

@protocol FilteringListControllerDelegate <NSObject>

/*- (void)controller:(FilteringListController *)controller
            itemId:(NSNumber *)itemId;*/
- (void)controller:(FilteringListController *)controller
            didPickItem:(Country *)item;
@end