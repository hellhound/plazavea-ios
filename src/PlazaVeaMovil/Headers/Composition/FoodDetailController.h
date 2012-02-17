#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Composition/Models.h"

@interface FoodDetailController : ReconnectableTableViewController
{
    Food *_food;
}
@property (nonatomic, retain) Food *food;

- (id)initWithFood:(Food *)food;
@end