#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/DiagnosisController.h"

static NSString *cellId = @"cellId";

@interface DiagnosisController ()

@property (nonatomic, retain) NSUserDefaults *defaults;
@end

@implementation DiagnosisController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        [self initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [self setTitle:kBodyMeterDiagnosisBackButton];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] 
            initWithTitle:kBodyMeterDiagnosisBackButton
                style:UIBarButtonItemStyleDone target:self action:NULL]];
    // Load profile
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    _profile = [[Profile alloc] init];
    
    [_profile setAge:[_defaults objectForKey:kBodyMeterAgeKey]];
    [_profile setGender:(kBodyMeterGenderType)
            [[_defaults objectForKey:kBodyMeterGenderKey] intValue]];
    [_profile setHeight:[_defaults objectForKey:kBodyMeterHeightKey]];
    [_profile setWeight:[_defaults objectForKey:kBodyMeterWeightKey]];
    [_profile setActivity:(kBodyMeterActivityType)
            [[_defaults objectForKey:kBodyMeterActivityKey] intValue]];
    
    _idealWeight = [_defaults objectForKey:kBodyMeterIdealWeightKey];
}

#pragma mark -
#pragma mark DiagnosisController (Public)

@synthesize profile = _profile, idealWeight = _idealWeight;

#pragma mark -
#pragma mark DiagnosisController (Private)

@synthesize defaults = _defaults;

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kBodyMeterDiagnosisSection:
            return 3;
            break;
        case kBodyMeterGoalSection:
            return 4;
            break;
        default:
            return 0;
            break;
    }
    return 0;
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
    NSString *textLabel;
    NSString *detailTextLabel = @"detail text label";
    
    switch ([indexPath section]) {
        case kBodyMeterDiagnosisSection:
            switch ([indexPath row]) {
                case kBodyMeterRangeRow:
                    textLabel = kBodyMeterRangeLabel;
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterCMIRow:
                    textLabel = kBodyMeterCMILabel;
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterResultRow:
                    textLabel = kBodyMeterResultLabel;
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                default:
                    break;
            }
            break;
        case kBodyMeterGoalSection:
            switch ([indexPath row]) {
                case kBodyMeterCalorieComsuptionRow:
                    textLabel = kBodyMeterCalorieConsumptionLabel;
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterTimeRow:
                    textLabel = kBodyMeterTimeLabel;
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterEnergyConsumptionRow:
                    textLabel = kBodyMeterEnergyConsumptionLabel;
                    detailTextLabel = @"";
                    [cell setAccessoryType:
                            UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case kBodyMeterRecomendationsRow:
                    textLabel = kBodyMeterRecomendationsLabel;
                    detailTextLabel = @"";
                    [cell setAccessoryType:
                            UITableViewCellAccessoryDisclosureIndicator];
                    break;
                default:
                    break;
            }
            break;
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
    switch (section) {
        case kBodyMeterDiagnosisSection:
            return kBodyMeterDiagnosisLabel;
            break;
        case kBodyMeterGoalSection:
            return [NSString stringWithFormat:
                    kBodyMeterGoalLabel , [_idealWeight intValue]];
            break;
        default:
            return nil;
            break;
    }
    return nil;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end