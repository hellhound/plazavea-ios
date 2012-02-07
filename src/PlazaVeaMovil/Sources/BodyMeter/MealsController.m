#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/MealsController.h"

static NSString *cellId = @"cellId";

@implementation MealsController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_meals release];
    [_energyConsumption release];
    [super dealloc];
}

#pragma mark -
#pragma mark MealsController

@synthesize energyConsumption = _energyConsumption, snacks = _snacks,
        meals = _meals;

- (id)initWithEnergyConsumption:(NSNumber *)energy snacks:(BOOL)snacks
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]) != nil) {
        _energyConsumption = [energy retain];
        _snacks = snacks;
        _meals = [[Meals alloc] initWithEnergyRequirement:energy snacks:snacks];
        
        [self setTitle:kBodyMeterMealsBackButton];
        [[self tableView] setAllowsSelection:NO];
        [[self view] setBackgroundColor:[UIColor colorWithWhite:kBodyMeterColor
                alpha:1.]];
    }
    return self;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_snacks)
        return 5;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                    reuseIdentifier:cellId] autorelease];
    }
    NSString *textLabel = kBodyMeterUndefinedLabel;
    NSString *detailTextLabel = kBodyMeterUndefinedLabel;
    Meal *meal = [[_meals meals] objectAtIndex:[indexPath section]];
    
    switch ([indexPath row]) {
        case 0:
            textLabel = kBodyMeterCaloriesLabel;
            detailTextLabel = [NSString stringWithFormat:
                    kBodyMeterCaloriesSufix, [[meal calories] floatValue]];
            break;
        case 1:
            textLabel = kBodyMeterCarbohidratesLabel;
            detailTextLabel = [NSString stringWithFormat:
                    kBodyMeterGramsSufix, [[meal carbohidrates] floatValue]];
            break;
        case 2:
            textLabel = kBodyMeterProteinsLabel;
            detailTextLabel = [NSString stringWithFormat:
                    kBodyMeterGramsSufix, [[meal proteins] floatValue]];
            break;
        case 3:
            textLabel = kBodyMeterFatLabel;
            detailTextLabel = [NSString stringWithFormat:
                    kBodyMeterGramsSufix, [[meal fat] floatValue]];
        default:
            break;
    }
    [[cell textLabel] setText:textLabel];
    [[cell detailTextLabel] setText:detailTextLabel];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return [[[_meals meals] objectAtIndex:section] name];
}
@end