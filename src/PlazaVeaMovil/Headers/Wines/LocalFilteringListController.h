#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/Constants.h"

@interface LocalFilteringListController: UITableViewController
{
    WineLocalFilteringListType _list;
}
@property (nonatomic, assign) WineLocalFilteringListType list;

- (id)initWithList:(WineLocalFilteringListType)list;
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end
