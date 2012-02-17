#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/RecomendationsController.h"

static NSString *cellId = @"cellId";
static float kfontSize = 16.;
static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@implementation RecomendationsController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_recomendations release];
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
    [footer setFont:[UIFont systemFontOfSize:kBodyMeterImageFooterFontSize]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(footerFontColor)]) {
        [footer setTextColor:(UIColor *)TTSTYLE(footerFontColor)];
    }
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
#pragma mark RecomendationsController

@synthesize recomendations = _recomendations;

- (id)initWithResult:(NSString *)result
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]) != nil) {
        _recomendations = [[NSString alloc] init];
        
        if ([result isEqualToString:kDiagnosisThinnessIILabel]) {
            _recomendations = kRecomendationsThinnessII;
        } else if ([result isEqualToString:kDiagnosisThinnessLabel]) {
            _recomendations = kRecomendationsThinness;
        } else if ([result isEqualToString:kDiagnosisNormalLabel]) {
            _recomendations = kRecomendationsNormal;
        } else if ([result isEqualToString:kDiagnosisOverWeightLabel]) {
            _recomendations = kRecomendationsOverWeight;
        } else if ([result isEqualToString:kDiagnosisObesityLabel]) {
            _recomendations = kRecomendationsObesity;
        } else if ([result isEqualToString:kDiagnosisObesityIILabel]) {
            _recomendations = kRecomendationsObesityII;
        } else if ([result isEqualToString:kDiagnosisObesityIIILabel]) {
            _recomendations = kRecomendationsObesityIII;
        } else {
            _recomendations = kBodyMeterUndefinedLabel;
        }
        [self setTitle:kBodyMeterRecomendationsBackButton];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    [[cell textLabel] setNumberOfLines:0];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:kfontSize]];
    [[cell textLabel] setText:_recomendations];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return kBodyMeterRecomendationsLabel;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (CGFloat)       tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [_recomendations sizeWithFont:
            [UIFont systemFontOfSize:kfontSize]
                constrainedToSize:CGSizeMake(280., MAXFLOAT)
                lineBreakMode:UILineBreakModeWordWrap].height;
    
    return height + 20.;
}
@end