#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface MealsController: UITableViewController
{
    NSNumber *_energyConsumption;
    BOOL _snacks;
    Meals *_meals;
}
@property (nonatomic, retain) NSNumber *energyConsumption;
@property (nonatomic, assign) BOOL snacks;
@property (nonatomic, retain) Meals *meals;
- (id)initWithEnergyConsumption:(NSNumber *)energy snacks:(BOOL)snacks;
@end