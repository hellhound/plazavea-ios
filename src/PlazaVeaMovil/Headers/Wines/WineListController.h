#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Wines/WineListDataSource.h"

@interface WineListController: ReconnectableTableViewController
{
    NSString *_categoryId;
}
@property (nonatomic, copy) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end