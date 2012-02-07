#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/DiagnosisController.h"
#import "BodyMeter/ProfileController.h"

typedef enum {
    kAccViewTag = 999,
    kCancelTag = 998,
    kDoneTag = 997
}Tags;

static int kProfileTagPrefix = 100;
static int kWeightTagPrefix = 200;
static CGFloat kPickerHeight = 162.;
static NSString *cellId = @"cellId";

@interface ProfileController ()

@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic, assign) pickerIndex pickerIndex;
@property (nonatomic, retain) NSMutableArray *pickerItems;
- (void)updateProfile;
- (void)dismissPicker:(id)sender;
- (void)pushDiagnosis;
- (void)goToLauncher;
@end

@implementation ProfileController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_profile release];
    [super dealloc];
}

- (id)init
{
    if ((self = [super init]) != nil) {
        [self initWithStyle:UITableViewStyleGrouped];
        [[self navigationController] setNavigationBarHidden:NO];
        [[self view] setBackgroundColor:[UIColor colorWithWhite:kBodyMeterColor
                alpha:1.]];
    }
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:kBodyMeterProfileBackButton];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] 
            initWithTitle:kBodyMeterDiagnosisBackButton
                style:UIBarButtonItemStyleDone target:self 
                action:@selector(pushDiagnosis)]];
    [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
            initWithTitle:@"Menú" style:UIBarButtonItemStyleBordered
                target:self action:@selector(goToLauncher)]];
    // Load profile
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    BOOL profileIsFull = YES;
    _profile = [[Profile alloc] init];
    
    [_profile setAge:[_defaults objectForKey:kBodyMeterAgeKey]];
    if (![_profile age])
        profileIsFull = NO;
    [_profile setGender:(kBodyMeterGenderType)
            [[_defaults objectForKey:kBodyMeterGenderKey] intValue]];
    if (![_profile gender])
        profileIsFull = NO;
    [_profile setHeight:[_defaults objectForKey:kBodyMeterHeightKey]];
    if (![_profile height])
        profileIsFull = NO;
    [_profile setWeight:[_defaults objectForKey:kBodyMeterWeightKey]];
    if (![_profile weight])
        profileIsFull = NO;
    [_profile setActivity:(kBodyMeterActivityType)
            [[_defaults objectForKey:kBodyMeterActivityKey] intValue]];
    if (![_profile activity])
        profileIsFull = NO;
    [_profile setIdealWeight:[_defaults objectForKey:kBodyMeterIdealWeightKey]];
    if (!profileIsFull) {
        [[[self navigationItem] rightBarButtonItem] setEnabled:NO];
        UIAlertView *alertView = [[[UIAlertView alloc]
                initWithTitle:kBodyMeterProfileAlertTitle
                    message:kBodyMeterProfileAlertMessage delegate:nil
                    cancelButtonTitle:kBodyMeterProfileAlertButton
                    otherButtonTitles:nil] autorelease];
        
        [alertView show];
    } else {
       // [self pushDiagnosis];
    }
}

/*- (void)viewDidAppear:(BOOL)animated
{
    BOOL profileIsFull = YES;
    
    if (![_profile age])
        profileIsFull = NO;
    [_profile setGender:(kBodyMeterGenderType)
     [[_defaults objectForKey:kBodyMeterGenderKey] intValue]];
    if (![_profile gender])
        profileIsFull = NO;
    [_profile setHeight:[_defaults objectForKey:kBodyMeterHeightKey]];
    if (![_profile height])
        profileIsFull = NO;
    [_profile setWeight:[_defaults objectForKey:kBodyMeterWeightKey]];
    if (![_profile weight])
        profileIsFull = NO;
    [_profile setActivity:(kBodyMeterActivityType)
     [[_defaults objectForKey:kBodyMeterActivityKey] intValue]];
    if (![_profile activity])
        profileIsFull = NO;
    [_profile setIdealWeight:[_defaults objectForKey:kBodyMeterIdealWeightKey]];
    if (!profileIsFull && _showProfile) {
        [super viewDidAppear:animated];
        _showProfile = NO;
    } else if (_showProfile) {
        [self pushDiagnosis];
        _showProfile = NO;
    }
}*/

#pragma mark -
#pragma mark ProfileController (Public)

@synthesize profile = _profile;

#pragma mark -
#pragma mark ProfileController (Private)

@synthesize defaults = _defaults, pickerIndex = _pickerIndex,
        pickerItems = _pickerItems;

- (void)updateProfile
{
    BOOL profileIsFull = YES;
    
    if (![_profile age]) {
        profileIsFull = NO;
    } else {
        [_defaults setObject:[_profile age] forKey:kBodyMeterAgeKey];
    }
    if (![_profile gender]) {
        profileIsFull = NO;
    } else {
        [_defaults setObject:[NSNumber numberWithInt:[_profile gender]]
                forKey:kBodyMeterGenderKey];
    }
    if (![_profile height]) {
        profileIsFull = NO;
    } else {
        [_defaults setObject:[_profile height] forKey:kBodyMeterHeightKey];
    }
    if (![_profile weight]) {
        profileIsFull = NO;
    } else {
        [_defaults setObject:[_profile weight] forKey:kBodyMeterWeightKey];
    }
    if (![_profile activity]) {
        profileIsFull = NO;
    } else {
        [_defaults setObject:[NSNumber numberWithInt:[_profile activity]]
                forKey:kBodyMeterActivityKey];
    }
    if ([_profile idealWeight]) {
        [_defaults setObject:[_profile idealWeight]
                forKey:kBodyMeterIdealWeightKey];
    }
    if (profileIsFull)
        [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
    [_defaults synchronize];
}

- (void)dismissPicker:(id)sender
{
    [[[[self view] superview] viewWithTag:kAccViewTag] removeFromSuperview];
    [[self tableView] setScrollEnabled:YES];
    [[self tableView] setAllowsSelection:YES];
    switch ([sender tag]) {
        case kDoneTag:
            if ([_pickerItems count] == 2) {
                [_profile setGender:_pickerIndex.row + 1];
            } else {
                [_profile setActivity:_pickerIndex.row + 1];
            }
            [self updateProfile];
            [[self tableView] reloadData];
            break;
        case kCancelTag:
        default:
            break;
    }
}

- (void)pushDiagnosis
{
    /*DiagnosisController *controller = [[DiagnosisController alloc] init];
    
    [[self navigationController] pushViewController:controller animated:YES];
    [controller release];*/
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:kBodyMeterShowDiagnosisNotification
            object:self];
}
     
- (void)goToLauncher
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:kbodyMeterGoToLauncherNotification
            object:self];
}

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
    NSString *textLabel;
    NSString *detailTextLabel;
    
    switch ([indexPath section]) {
        case kBodyMeterProfileSection:
            switch ([indexPath row]) {
                case kBodyMeterAgeRow:
                    textLabel = kBodyMeterAgeLabel;
                    detailTextLabel = [_profile age] ?
                            [NSString stringWithFormat:kBodyMeterAgeSufix,
                                [[_profile age] intValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case kBodyMeterGenderRow:
                    textLabel = kBodyMeterGenderLabel;
                    switch ([_profile gender]) {
                        case kBodyMeterGenderUndefined:
                            detailTextLabel = kBodyMeterUndefinedLabel;
                            break;
                        case kBodyMeterGenderMale:
                            detailTextLabel = kBodyMeterMaleLabel;
                            break;
                        case kBodyMeterGenderFemale:
                            detailTextLabel = kBodyMeterFemaleLabel;
                        default:
                            break;
                    }
                    break;
                case kBodyMeterHeightRow:
                    textLabel = kBodyMeterHeightLabel;
                    detailTextLabel = [_profile height] ?
                            [NSString stringWithFormat:kBodyMeterHeightSufix,
                                [[_profile height] floatValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case kBodyMeterWeightRow:
                    textLabel = kBodyMeterWeightLabel;
                    detailTextLabel = [_profile weight] ?
                            [NSString stringWithFormat:kBodyMeterWeightSufix,
                                [[_profile weight] intValue]] :
                                kBodyMeterUndefinedLabel;
                    break;
                case kBodyMeterActivityRow:
                    textLabel = kBodyMeterActivityLabel;
                    switch ([_profile activity]) {
                        case kBodyMeterActivityUndefined:
                            detailTextLabel = kBodyMeterUndefinedLabel;
                            break;
                        case kBodyMeterActivityMinimal:
                            detailTextLabel = kBodyMeterMinimalLabel;
                            break;
                        case kBodyMeterActivityLight:
                            detailTextLabel = kBodyMeterLightLabel;
                            break;
                        case kBodyMeterActivityModerate:
                            detailTextLabel = kBodyMeterModerateLabel;
                            break;
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
            switch ([indexPath row]) {
                case kBodyMeterIdealWeightRow:
                    textLabel = kBodyMeterIdealWeightLabel;
                    detailTextLabel = [_profile idealWeight] ? [NSString
                            stringWithFormat:kBodyMeterWeightSufix,
                                [[_profile idealWeight] intValue]] :
                                kBodyMeterUndefinedLabel;
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

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TSAlertView *alertView = [[[TSAlertView alloc] initWithTitle:nil
            message:nil delegate:self
                cancelButtonTitle:kBodyMeterEntryAlertCancel
                otherButtonTitles:kBodyMeterEntryAlertOK, nil] autorelease];
    
    [alertView setStyle:TSAlertViewStyleInput];
    
    UITextField *textField = [alertView firstTextField];
    
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    switch ([indexPath section]) {
        case kBodyMeterProfileSection:
            switch ([indexPath row]) {
                case kBodyMeterAgeRow:
                    [alertView setTitle:kBodyMeterAgeEntry];
                    [alertView setTag:kProfileTagPrefix + kBodyMeterAgeRow];
                    break;
                case kBodyMeterGenderRow:
                    break;
                case kBodyMeterHeightRow:
                    [alertView setTitle:kBodyMeterHeightEntry];
                    [alertView setTag:kProfileTagPrefix + kBodyMeterHeightRow];                    
                    break;
                case kBodyMeterWeightRow:
                    [alertView setTitle:kBodyMeterWeightEntry];
                    [alertView setTag:kProfileTagPrefix + kBodyMeterWeightRow];
                    break;
                case kBodyMeterActivityRow:
                    break;
                default:
                    break;
            }
            break;
        case kBodyMeterWeightSection:
            switch ([indexPath row]) {
                case kBodyMeterIdealWeightRow:
                    [alertView setTitle:kBodyMeterIdealWeightEntry];
                    [alertView setTag:
                            kWeightTagPrefix + kBodyMeterIdealWeightRow];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    if ([alertView title] != nil) {
        [alertView show];
    } else {
        if (_pickerItems == nil)
            _pickerItems = [[NSMutableArray alloc] init];
        switch ([indexPath row]) {
            case kBodyMeterGenderRow:
                [_pickerItems removeAllObjects];
                [_pickerItems addObjectsFromArray:[NSArray arrayWithObjects:
                        kBodyMeterMaleLabel,
                        kBodyMeterFemaleLabel,
                        nil]];
                break;
            case kBodyMeterActivityRow:
                [_pickerItems removeAllObjects];
                [_pickerItems addObjectsFromArray:[NSArray arrayWithObjects:
                        kBodyMeterMinimalLabel,
                        kBodyMeterLightLabel,
                        kBodyMeterModerateLabel,
                        kBodyMeterIntenseLabel,
                        nil]];
                break;
            default:
                break;
        }
        [[self tableView] setAllowsSelection:NO];
        [[self tableView] setScrollEnabled:NO];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                    target:nil action:NULL];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] 
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                    target:self action:@selector(dismissPicker:)];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] 
                initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                    target:self action:@selector(dismissPicker:)];
        
        [done setTag:kDoneTag];
        [cancel setTag:kCancelTag];
        [toolbar sizeToFit];
        [toolbar setItems:[NSArray arrayWithObjects:cancel, spacer, done, nil]];
        
        UIPickerView *pickerView =
                [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
        
        [pickerView setDelegate:self];
        [pickerView setDataSource:self];
        [pickerView setShowsSelectionIndicator:YES];
        [pickerView setFrame:CGRectMake(.0, [toolbar frame].size.height,
                [[self view] frame].size.width, kPickerHeight)];
        
        UIView *accView =
                [[UIView alloc] initWithFrame:CGRectZero];
        
        [accView setTag:kAccViewTag];
        [accView addSubview:toolbar];
        [accView addSubview:pickerView];
        CGFloat height = [toolbar frame].size.height +
        [pickerView frame].size.height;
        [accView setFrame:CGRectMake(.0,
                [[self tableView] frame].size.height - height,
                    [[self view] frame].size.width, height)];
        [[[self view] superview] addSubview:accView];
        [toolbar release];
        [pickerView release];
    }
}

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)    alertView:(TSAlertView *)alertView
 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSNumber *value = [NSNumber numberWithInt:
            [[[alertView firstTextField] text] intValue]];
    
    if (buttonIndex != [alertView cancelButtonIndex]) {
        if ([[[alertView firstTextField] text] length] == 0) {
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
        } else {
            if (([alertView tag] == kProfileTagPrefix + kBodyMeterAgeRow) &&
                    value != 0) {
                [_profile setAge:value];
            } else if (([alertView tag] ==
                    kProfileTagPrefix + kBodyMeterHeightRow) && value != 0) {
                [_profile setHeight:
                        [NSNumber numberWithFloat:([value floatValue] / 100.)]];
            } else if (([alertView tag] ==
                    kProfileTagPrefix + kBodyMeterWeightRow) && value != 0) {
                [_profile setWeight:value];
            } else if (([alertView tag] ==
                    kProfileTagPrefix + kBodyMeterHeightRow) && value != 0) {
                [_profile setHeight:value];
            } else if (([alertView tag] == kWeightTagPrefix +
                    kBodyMeterIdealWeightRow) && value != 0) {
                [_profile setIdealWeight:value];
            }
        }
    }
    [self updateProfile];
    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark <UIPickerViewDataSource>

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerItems count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark -
#pragma mark <UIPickerViewDelegate>

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [_pickerItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    _pickerIndex.row = row;
    _pickerIndex.component = component;
}
@end