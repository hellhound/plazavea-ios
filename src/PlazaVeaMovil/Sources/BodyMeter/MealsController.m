#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/MealsController.h"

static NSString *cellId = @"cellId";
static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

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
#pragma mark UIViewController

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