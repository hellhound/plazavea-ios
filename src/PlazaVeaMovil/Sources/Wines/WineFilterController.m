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

- (void)dealloc
{
    [_selectedItemsIds release];
    [_selectedItemsNames release];
    [super dealloc];
}

- (id)init
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
        _clearFilters = YES;
    }
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_clearFilters) {
        for (int i = 0; i < 5; i ++) {
            if (_selectedItemsNames)
                [_selectedItemsNames  replaceObjectAtIndex:i withObject:@""];
            if (_selectedItemsIds)
                [_selectedItemsIds replaceObjectAtIndex:i
                        withObject:[NSNull null]];
        }
        [[self tableView] reloadData];
    }
    _clearFilters = YES;
}

#pragma mark -
#pragma mark WineFilterController

@synthesize country = _country, winery = _winery, category = _category,
        strain = _strain, price = _price, selectedItemsIds = _selectedItemsIds,
            selectedItemsNames = _selectedItemsNames,
            clearFilters = _clearFilters;

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
                    if ([_selectedItemsNames objectAtIndex:
                            ([indexPath row] - 1)] == kWineSparklingLabel) {
                        textLabel = kWineSparklingTypeLabel;
                    } else {
                        textLabel = kWineStrainLabel;
                    }
                    break;
                case kWinePriceRow:
                    textLabel = kWinePriceLabel;
                    break;
                default:
                    break;
            }
            [[cell detailTextLabel] setText:[_selectedItemsNames
                    objectAtIndex:[indexPath row]]];
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
                    _clearFilters = NO;
                    break;
                case kWineWineryRow:
                    [[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"1")]
                                applyAnimated:YES]];
                    _clearFilters = NO;
                    break;
                case kWineCategoryRow:
                    /*[[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:URL(kURLFilteringCall, @"2")]
                                applyAnimated:YES]];*/
                    [controller setList:kWineCategoryLocalFilter];
                    [controller setDelegate:self];
                    [[self navigationController] pushViewController:controller
                            animated:YES];
                    _clearFilters = NO;
                    break;    
                case kWineStrainRow: {
                    NSString *url;
                    if ([_selectedItemsNames objectAtIndex:
                            ([indexPath row] - 1)] == kWineSparklingLabel) {
                        url = URL(kURLFilteringCall, @"4");
                    } else {
                        url = URL(kURLFilteringCall, @"3");
                    }
                    [[TTNavigator navigator] openURLAction:[[TTURLAction
                            actionWithURLPath:url] applyAnimated:YES]];
                    _clearFilters = NO;
                     }
                    break;
                case kWinePriceRow:
                    [controller setList:kWinePriceLocalFilter];
                    [controller setDelegate:self];
                    [[self navigationController] pushViewController:controller
                            animated:YES];
                    _clearFilters = NO;
                    break;
                default:
                    break;
            }
            break;
        case kWineGoSection:
            switch ([indexPath row]) {
                case kWineGoRow:
                {
                    NSString *filters = [[[NSString alloc] initWithString:@""]
                            autorelease];
                    
                    /*for (NSString *filter in _selectedItemsIds) {
                        if (![filter isKindOfClass:[NSNull class]]) {
                            filters = [filters stringByAppendingString:filter];
                        }
                    }*/
                    for (int index = 0; index < [_selectedItemsIds count];
                            index++) {
                        NSString *filter =
                                [_selectedItemsIds objectAtIndex:index];
                        if (index == 0) {
                            if (![filter isKindOfClass:[NSNull class]]) {
                                filters = [filters
                                        stringByAppendingString:filter];
                            }
                        } else {
                            if (![filter isKindOfClass:[NSNull class]]) {
                                filters = [filters stringByAppendingFormat:
                                        @"&%@", filter];
                            }
                        }
                    }
                    if ([filters isEqualToString:@""]) {
                        UIAlertView *alert = [[[UIAlertView alloc]
                                initWithTitle:kWineNoFilterTitle
                                    message:kWineNoFilterMessage delegate:nil
                                    cancelButtonTitle:kWineNoFilterButton
                                    otherButtonTitles:nil] autorelease];
                        
                        [alert show];
                    } else {
                        [[TTNavigator navigator] openURLAction:[[TTURLAction
                                actionWithURLPath:URL(kURLFilteredWineListCall,
                                    filters)] applyAnimated:YES]];
                        }
                    break;
                }
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
       didPickItem:(Country *)item
{
    if (!_selectedItemsNames) {
        _selectedItemsNames = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i ++) {
            [_selectedItemsNames addObject:@""];
        }
    }
    if (!_selectedItemsIds) {
        _selectedItemsIds = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i ++) {
            [_selectedItemsIds addObject:[NSNull null]];
        }
    }
    int index;
    switch ([controller list]) {
        case 0:
            index = 0;
            break;
        case 3:
            index = 2;
            break;
        case 1:
            index = 4;
            break;
        case 4:
            index = 2;
            break;
        default:
            index = 0;
            break;
    }
    [_selectedItemsNames replaceObjectAtIndex:index withObject:[item name]];
    if ([item countryId] != nil) {
        if (index == 2) {
            [_selectedItemsIds replaceObjectAtIndex:index withObject:
                    [NSString stringWithFormat:kWineKindFilterPrefix,
                        [[item countryId] intValue]]];
        } else if (index == 4) {
            [_selectedItemsIds replaceObjectAtIndex:index withObject:
                    [NSString stringWithFormat:kWineWineryFilterPrefix,
                        [[item countryId] intValue]]];
        }
    } else {
        [_selectedItemsIds replaceObjectAtIndex:index withObject:
                [NSString stringWithFormat:kWineCountryFilterPrefix,
                    [item code]]];
    }
    [[self tableView] reloadData];
}

- (void)controller:(LocalFilteringListController *)controller
didPickLocalItemId:(int)itemId
{
    if (!_selectedItemsNames) {
        _selectedItemsNames = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i ++) {
            [_selectedItemsNames addObject:@""];
        }
    }
    if (!_selectedItemsIds) {
        _selectedItemsIds = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i ++) {
            [_selectedItemsIds addObject:[NSNull null]];
        }
    }
    NSString *label = [[NSString alloc] init];
    
    if ([controller list] == kWineCategoryLocalFilter) {
        // reset wine type
        [_selectedItemsIds replaceObjectAtIndex:kWineStrainRow
                    withObject:[NSNull null]];
        [_selectedItemsNames replaceObjectAtIndex:kWineStrainRow
                    withObject:@""];
        
        label = kWineSparklingLabel;
        
        [_selectedItemsNames replaceObjectAtIndex:kWineCategoryRow
                withObject:label];
        [_selectedItemsIds replaceObjectAtIndex:kWineCategoryRow withObject:
                [NSString stringWithFormat:@"cat=2"]];
    } else if ([controller list] == kWinePriceLocalFilter) {
        switch (itemId) {
            case 0:
                label = kWineLessThanLabel;
                break;
            case 1:
                label = kWineBetweenLabel;
                break;
            case 2:
                label = kWineMoreThanLabel;
                break;
            default:
                break;
        }
        [_selectedItemsNames replaceObjectAtIndex:kWinePriceRow
                withObject:label];
        [_selectedItemsIds replaceObjectAtIndex:kWinePriceRow withObject:
                [NSString stringWithFormat:kWinePriceFilterPrefix,
                    (itemId + 1)]];
    } else if ([controller list] == kWineWinesLocalFilter) {
        // reset wine type
        [_selectedItemsIds replaceObjectAtIndex:kWineStrainRow
                withObject:[NSNull null]];
        [_selectedItemsNames replaceObjectAtIndex:kWineStrainRow
                withObject:@""];
        
        int catId = 0;
        switch (itemId) {
            case 0:
                label = kWineWhiteLabel;
                catId = 4;
                break;
            case 1:
                label = kWineRoseLabel;
                catId = 5;
                break;
            case 2:
                label = kWineRedLabel;
                catId = 3;
                break;
            case 3:
                label = kWineAllLabel;
                catId = 1;
                break;
            default:
                break;
        }
        [_selectedItemsNames replaceObjectAtIndex:kWineCategoryRow
                withObject:label];
        [_selectedItemsIds replaceObjectAtIndex:kWineCategoryRow withObject:
                [NSString stringWithFormat:@"cat=%i", catId]];
    }
    [[self tableView] reloadData];
}
@end