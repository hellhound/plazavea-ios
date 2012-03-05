#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/LocalFilteringListController.h"
#import "Wines/WineFilterController.h"
#import "Wines/Constants.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation WineFilterController

#pragma mark -
#pragma mark NSObject

- (id) init
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]) != nil) {
        // Conf nav bar
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
        [[self tableView] setTableHeaderView:[self viewWithImageURL:nil
                title:kSomelierTitle]];
        [[self view] setBackgroundColor:[UIColor colorWithWhite:kWineColor
                alpha:1.]];
    }
    return self;
}

#pragma mark -
#pragma mark WineFilterController

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
    [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBannerImage)] autorelease];
    
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
    
    UIFont *font = [titleLabel font];
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
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth, kWineDetailImageHeight +
            titleHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
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
        case kWineFilterSection:
            return 5;
            break;
        case kWineGoSection:
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
    NSString *textLabel = kWineUndefinedLabel;
    NSString *detailTextLabel = kWineUndefinedLabel;
    
    switch ([indexPath section]) {
        case kWineFilterSection:
            switch ([indexPath row]) {
                case kWineCountryRow:
                    textLabel = kWineCountryLabel;
                    break;
                case kWineWineryRow:
                    textLabel = kWineWineryLabel;
                    break;
                case kWineCategoryRow:
                    textLabel = kWineCategoryLabel;
                    break;
                case kWineStrainRow:
                    textLabel = kWineStrainLabel;
                    break;
                case kWinePriceRow:
                    textLabel = kWinePriceLabel;
                    break;
                default:
                    break;
            }
            break;
        case kWineGoSection:
            switch ([indexPath row]) {
                case kWineGoRow:
                    textLabel = kWineGoLabel;
                    detailTextLabel = @"";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [[cell textLabel] setText:textLabel];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[cell detailTextLabel] setText:detailTextLabel];
    [[cell detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LocalFilteringListController *controller =
            [[[LocalFilteringListController alloc]
                initWithStyle:UITableViewStylePlain] 
                autorelease];
    
    switch ([indexPath section]) {
        case kWineFilterSection:
            switch ([indexPath row]) {
                case kWineCountryRow:
                    [[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"0")]
                                applyAnimated:YES]];
                    break;
                case kWineWineryRow:
                    [[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"1")]
                                applyAnimated:YES]];
                    break;
                case kWineCategoryRow:
                    /*[[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"2")]
                                applyAnimated:YES]];*/
                    [controller setList:kWineCategoryLocalFilter];
                    [[self navigationController] pushViewController:controller
                            animated:YES];
                    break;    
                case kWineStrainRow:
                    [[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"3")]
                                applyAnimated:YES]];
                    break;
                case kWinePriceRow:
                    [controller setList:kWinePriceLocalFilter];
                    [[self navigationController] pushViewController:controller
                            animated:YES];
                    break;
                default:
                    break;
            }
            break;
        case kWineGoSection:
            switch ([indexPath row]) {
                case kWineGoRow:
                    [[TTNavigator navigator] openURLAction:
                            [[TTURLAction actionWithURLPath:kURLStrainListCall]
                                applyAnimated:YES]];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark <FilteringListControllerDelegate>

- (void)controller:(FilteringListController *)controller
            itemId:(NSNumber *)itemId
{
    NSLog(@"list: %i, item Id: %i", [controller list], [itemId intValue]); 
}
@end