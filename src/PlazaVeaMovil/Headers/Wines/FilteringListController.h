#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Wines/Constants.h"

@interface FilteringListController: ReconnectableTableViewController
{
    WineFilteringListType _list;
}
@property (nonatomic, assign) WineFilteringListType list;

- (id)initWithList:(NSString *)list;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
- (void)back:(id)sender;
@end