#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Composition/Models.h"

@interface FoodDetailController : ReconnectableTableViewController
{
    Food *_food;
    UIImage *_banner;
}
@property (nonatomic, retain) Food *food;
@property (nonatomic, retain) UIImage *banner;

- (id)initWithFood:(Food *)food;
@end