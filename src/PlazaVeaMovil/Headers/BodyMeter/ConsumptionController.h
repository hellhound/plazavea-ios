#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface ConsumptionController: UITableViewController
{
    NSNumber *_energyConsumption;
}
@property (nonatomic, retain) NSNumber *energyConsumption;
- (id)initWithEnergyConsumption:(NSNumber *)energy;
@end