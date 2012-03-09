#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/Models.h"
#import "Wines/FilteringListController.h"
#import "Wines/LocalFilteringListController.h"

@interface WineFilterController: UITableViewController
        <FilteringListControllerDelegate, LocalFilteringListControllerDelegate>
{
    NSNumber *_country;
    NSNumber *_winery;
    NSNumber *_category;
    NSNumber *_strain;
    NSNumber *_price;
    NSMutableArray *_selectedItemsNames;
    NSMutableArray *_selectedItemsIds;
}
@property (nonatomic, retain) NSNumber *country;
@property (nonatomic, retain) NSNumber *winery;
@property (nonatomic, retain) NSNumber *category;
@property (nonatomic, retain) NSNumber *strain;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSMutableArray *selectedItemsNames;
@property (nonatomic, retain) NSMutableArray *selectedItemsIds;

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end