#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Composition/Models.h"

@interface FoodDetailController : EditableCellTableViewController
{
    UINavigationItem *_navItem;
    Food *_food;
}
@property (nonatomic, retain) Food *food;

- (id)initWithFood:(Food *)food;
@end