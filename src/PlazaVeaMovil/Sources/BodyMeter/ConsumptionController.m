#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/MealsController.h"
#import "BodyMeter/ConsumptionController.h"

static NSString *cellId = @"cellId";

@implementation ConsumptionController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_energyConsumption release];
    [super dealloc];
}

#pragma mark -
#pragma mark ConsumptionController

@synthesize energyConsumption = _energyConsumption;

- (id)initWithEnergyConsumption:(NSNumber *)energy
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]) != nil) {
        _energyConsumption = [energy retain];
        
        [self setTitle:kBodyMeterConsumptionBackButton];
        [[self view] setBackgroundColor:[UIColor colorWithWhite:kBodyMeterColor
                alpha:1.]];
    }
    return self;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellId] autorelease];
    }
    NSString *textLabel;
    if ([indexPath row] == 0) {
        textLabel = [NSString stringWithFormat:kBodyMeterMealsADay, 3];
    } else {
        textLabel = [NSString stringWithFormat:kBodyMeterMealsADay, 5];
    }
    [[cell textLabel] setText:textLabel];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return kBodyMeterEnergyConsumptionLabel;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MealsController *controller;
    switch ([indexPath row]) {
        case 0:
            controller = [[MealsController alloc]
                    initWithEnergyConsumption:_energyConsumption snacks:NO];
            break;
        case 1:
            controller = [[MealsController alloc]
                    initWithEnergyConsumption:_energyConsumption snacks:YES];
            break;
        default:
            break;
    }
    [[self navigationController] pushViewController:controller animated:YES];
}
@end