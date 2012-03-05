#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/Models.h"
#import "Wines/FilteringListController.h"

@interface WineFilterController: UITableViewController
        <FilteringListControllerDelegate>
{
    
}
- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end