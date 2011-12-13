#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Composition/Models.h"

@interface FoodDetailDataSource: TTListDataSource

- (id)initWithFood:(Food *)food;
@end