#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Composition/Models.h"

@interface FoodListController : EditableCellTableViewController
{
    UINavigationItem *_navItem;
    FoodCategory *_foodCategory;
}
@property (nonatomic, retain) FoodCategory *foodCategory;

- (id)initWithCategory:(FoodCategory *)foodCategory;
@end