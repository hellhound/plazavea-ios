#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/ProfileController.h"

static NSString *cellId = @"cellId";

@interface ProfileController ()

@property (nonatomic, retain) NSUserDefaults *defaults;
@end

@implementation ProfileController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [super dealloc];
}

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
    [self setTitle:kBodyMeterTitle];
    // Load profile
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
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
#pragma mark ProfileController (Public)

@synthesize profile = _profile, idealWeight = _idealWeight;

#pragma mark -
#pragma mark ProfileController (Private)

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
        case kBodyMeterProfileSection:
            return 5;
            break;
        case kBodyMeterWeightSection:
            return 1;
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
    NSString *textLabel = @"";
    NSString *detailTextLabel = @"";
    
    switch ([indexPath section]) {
        case kBodyMeterProfileSection:
            switch ([indexPath row]) {
                case 0:
                    textLabel = kBodyMeterAgeLabel;
                    detailTextLabel = [_profile age] ?
                            [NSString stringWithFormat:kBodyMeterAgeSufix,
                                [[_profile age] intValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case 1:
                    textLabel = kBodyMeterGenderLabel;
                    switch ([_profile gender]) {
                        case kBodyMeterGenderUndefined:
                            detailTextLabel = kBodyMeterUndefinedLabel;
                            break;
                        case kBodyMeterGenderMale:
                            detailTextLabel = kBodyMeterMaleLabel;
                        case kBodyMeterGenderFemale:
                            detailTextLabel = kBodyMeterFemaleLabel;
                        default:
                            break;
                    }
                    break;
                case 2:
                    textLabel = kBodyMeterHeightLabel;
                    detailTextLabel = [_profile height] ?
                            [NSString stringWithFormat:kBodyMeterHeightSufix,
                                [[_profile height] floatValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case 3:
                    textLabel = kBodyMeterWeightLabel;
                    detailTextLabel = [_profile weight] ?
                            [NSString stringWithFormat:kBodyMeterWeightSufix,
                                [[_profile weight] floatValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case 4:
                    textLabel = kBodyMeterActivityLabel;
                    switch ([_profile activity]) {
                        case kBodyMeterActivityUndefined:
                            detailTextLabel = kBodyMeterUndefinedLabel;
                            break;
                        case kBodyMeterActivityMinimal:
                            detailTextLabel = kBodyMeterMinimalLabel;
                        case kBodyMeterActivityLight:
                            detailTextLabel = kBodyMeterLightLabel;
                        case kBodyMeterActivityModerate:
                            detailTextLabel = kBodyMeterModerateLabel;
                        case kBodyMeterActivityIntense:
                            detailTextLabel = kBodyMeterIntenseLabel;
                        default:
                            break;
                    }
                    break;
                default:
                    break;
            }
            break;
        case kBodyMeterWeightSection:
            textLabel = kBodyMeterIdealWeightLabel;
            detailTextLabel = _idealWeight ? [NSString stringWithFormat:
                    kBodyMeterWeightSufix, [_idealWeight floatValue]] :
                        kBodyMeterUndefinedLabel;
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
        case kBodyMeterProfileSection:
            return kBodyMeterProfileHeaderLabel;
            break;
        case kBodyMeterWeightSection:
            return kBodyMeterWeightHeaderLabel;
            break;
        default:
            return nil;
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
    switch (section) {
        case kBodyMeterProfileSection:
            return kBodyMeterProfileFooterLabel;
            break;
        case kBodyMeterWeightSection:
            return kBodyMeterWeightFooterLabel;
            break;
        default:
            return nil;
            break;
    }
    return nil;
}
@end