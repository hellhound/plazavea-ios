#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"
#import "Wines/Constants.h"
#import "Wines/WineListDataSource.h"

@interface WineListController: ReconnectableTableViewController
        <WineListDataSourceDelegate>
{
    WineDetailFromType _from;
    NSString *_categoryId;
}
@property (nonatomic, assign) WineDetailFromType from;
@property (nonatomic, copy) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithCategoryId:(NSString *)categoryId from:(NSString *)from;
@end