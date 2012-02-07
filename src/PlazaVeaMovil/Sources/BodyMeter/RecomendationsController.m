#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"
#import "BodyMeter/RecomendationsController.h"

static NSString *cellId = @"cellId";
static float kfontSize = 16.;

@implementation RecomendationsController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_recomendations release];
    [super dealloc];
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