#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/ProfileController.h"
#import "BodyMeter/ConsumptionController.h"
#import "BodyMeter/RecomendationsController.h"
#import "BodyMeter/DiagnosisController.h"

static NSString *cellId = @"cellId";
static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface DiagnosisController ()

@property (nonatomic, retain) NSUserDefaults *defaults;
- (void)dismissProfile;
- (void)dismissBodyMeter;
- (void)showProfile;
@end

@implementation DiagnosisController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_profile release];
    [_diagnosis release];
    [super dealloc];
}

- (id)init
{
    if ((self = [super init]) != nil) {
        [self initWithStyle:UITableViewStyleGrouped];
        [[self view] setBackgroundColor:[UIColor colorWithWhite:kBodyMeterColor
                alpha:1.]];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self selector:@selector(dismissProfile)
                name:kBodyMeterShowDiagnosisNotification object:nil];
        [center addObserver:self selector:@selector(dismissBodyMeter)
                name:kbodyMeterGoToLauncherNotification object:nil];
    }
    return self;
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:kBodyMeterDiagnosisBackButton];
    /*[[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] 
            initWithTitle:kBodyMeterProfileBackButton
                style:UIBarButtonItemStyleBordered target:self 
                action:@selector(showProfile)]];*/
    // Load profile
    if (_defaults == nil)
        _defaults = [NSUserDefaults standardUserDefaults];
    if (_profile == nil)
        _profile = [[Profile alloc] init];
    if (_diagnosis == nil)
        _diagnosis = [[Diagnosis alloc] initWithProfile:_profile];
}

- (void)loadView
{
    [super loadView];
    // Conf nav bar
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
    
    UITableView *tableView = [self tableView];
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectZero]
            autorelease];
    // Conf the image
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kBodyMeterBannerImage)] autorelease];

    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
    // Conf the label
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    
    NSString *title = kBodyMeterTitle;
    UIFont *font = [titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2.)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2.;
        titleHeight = headerMinHeight - (margin * 2.);
    } else {
        titleFrame.origin.y += margin;
    }
    [titleLabel setText:title];
    [titleLabel setFrame:titleFrame];
    //Conf the footer
    UILabel *footer = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [footer setNumberOfLines:0];
    [footer setLineBreakMode:UILineBreakModeWordWrap];
    [footer setTextAlignment:UITextAlignmentLeft];
    [footer setBackgroundColor:[UIColor clearColor]];
    [footer setFont:[UIFont systemFontOfSize:kBodyMeterFooterFontSize]];
    [footer setTextColor:[UIColor darkGrayColor]];
    [footer setShadowColor:[UIColor whiteColor]];
    [footer setShadowOffset:CGSizeMake(.0, 1.)];
    
    font = [footer font];
    CGFloat footerWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedFooterSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat footerHeight = [kBodyMeterFooter sizeWithFont:font
            constrainedToSize:constrainedFooterSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect footerFrame = CGRectMake(.0, .0, footerWidth, footerHeight);
    
    [footer setText:kBodyMeterFooter];
    [footer setFrame:CGRectOffset(footerFrame, margin, kBodyMeterBannerHeight +
            titleHeight + (margin * 2.))];
    
    UIView *footerBackground = [[[UIView alloc] initWithFrame:
            CGRectOffset(footerFrame, .0, kBodyMeterBannerHeight + titleHeight +
                (margin * 2.))] autorelease];
    
    [footerBackground setBackgroundColor:
            [UIColor colorWithWhite:kBodyMeterColor alpha:1.]];

    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth, kBodyMeterBannerHeight
            + titleHeight + footerHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    [headerView addSubview:footerBackground];
    [headerView addSubview:footer];
    // Conf background
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kBodyMeterBackgroundImage)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:headerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [_profile setIdealWeight:[_defaults objectForKey:kBodyMeterIdealWeightKey]];
    
    _diagnosis = [[Diagnosis alloc] initWithProfile:_profile];
    BOOL profileIsFull = YES;
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
    if (profileIsFull) {        
        [super viewDidAppear:animated];
        [[self tableView] reloadData];
    } else {
        [self showProfile];
    }
}

#pragma mark -
#pragma mark DiagnosisController (Public)

@synthesize profile = _profile, diagnosis = _diagnosis;

#pragma mark -
#pragma mark DiagnosisController (Private)

@synthesize defaults = _defaults;
         
- (void)dismissProfile
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dismissBodyMeter
{
    [self dismissModalViewControllerAnimated:YES];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)showProfile
{
    ProfileController *controller = [[ProfileController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:controller];
    if ([TTStyleSheet
         hasStyleSheetForSelector:@selector(navigationBarTintColor)]) {
        [[navController navigationBar]
                setTintColor:(UIColor *)TTSTYLE(navigationBarTintColor)];
    }
    
    [self presentModalViewController:navController animated:YES];
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kBodyMeterUpdateSection:
            return 1;
            break;
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
    NSString *textLabel = kBodyMeterUndefinedLabel;
    NSString *detailTextLabel = kBodyMeterUndefinedLabel;
    
    switch ([indexPath section]) {
        case kBodyMeterUpdateSection:
            switch ([indexPath row]) {
                case 0:
                    textLabel = kBodyMeterUpdateLabel;
                    detailTextLabel = @"";
                    break;
                default:
                    break;
            }
            break;
        case kBodyMeterDiagnosisSection:
            switch ([indexPath row]) {
                case kBodyMeterRangeRow:
                    textLabel = kBodyMeterRangeLabel;
                    detailTextLabel = [_diagnosis weightRange];
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterCMIRow:
                    textLabel = kBodyMeterCMILabel;
                    detailTextLabel = [NSString stringWithFormat:
                            kBodyMeterCMISufix, [[_diagnosis bodyMassIndex]
                                floatValue]];
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterResultRow:
                    textLabel = kBodyMeterResultLabel;
                    detailTextLabel = [_diagnosis result];
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
                    detailTextLabel = [NSString stringWithFormat:
                            kBodyMeterConsumptionSufix, 
                                [[_diagnosis energyConsumption] floatValue]];
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    break;
                case kBodyMeterTimeRow:
                    textLabel = kBodyMeterTimeLabel;
                    detailTextLabel = [NSString stringWithFormat:
                            kBodyMeterTimeSufix,
                                [[_diagnosis time] floatValue]];
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
    [[cell detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case kBodyMeterDiagnosisSection:
            return [NSString stringWithFormat:
                    kBodyMeterDiagnosisLabel, [[_profile weight] intValue]];
            break;
        case kBodyMeterGoalSection:
            return [NSString stringWithFormat:
                    kBodyMeterGoalLabel, [[_profile idealWeight] intValue]];
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
    if ([indexPath section] == kBodyMeterUpdateSection) {
        if ([indexPath row] == 0) {
            [self showProfile];
        }
    } else if ([indexPath section] == kBodyMeterGoalSection) {
        if ([indexPath row] == 2) {
            ConsumptionController *controller = [[ConsumptionController alloc]
                    initWithEnergyConsumption:[_diagnosis energyConsumption]];
            
            [[self navigationController] pushViewController:controller
                    animated:YES];
        } else if ([indexPath row] == 3) {
            RecomendationsController *controller =
                    [[RecomendationsController alloc]
                        initWithResult:[_diagnosis result]];
            
            [[self navigationController] pushViewController:controller
                    animated:YES];
        }
    }
}
@end