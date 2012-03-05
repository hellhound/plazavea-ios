#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WineFilterController.h"
#import "Wines/LocalFilteringListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation LocalFilteringListController

#pragma mark - 
#pragma mark UITableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]) != nil) {
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
            [[self tableView] setTableHeaderView:[self viewWithImageURL:nil
                    title:kSomelierTitle]];
        }
    }
    return self;
}

#pragma mark -
#pragma mark LocalFilteringListController

@synthesize list = _list;

- (id)initWithList:(WineLocalFilteringListType)list
{
    if ((self = [self initWithStyle:UITableViewStylePlain]) != nil)
        _list = list;
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    /*UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBannerImage)] autorelease];
    
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];*/
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
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth,
            titleHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    /*[imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];*/
    [headerView addSubview:titleLabel];
    //[headerView addSubview:imageView];
    
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}

#pragma mark -
#pragma mark <UITableViewController>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (_list) {
        case kWineCategoryLocalFilter:
            return 2;
            break;
        case kWineWinesLocalFilter:
            return 4;
            break;
        case kWinePriceLocalFilter:
            return 3;
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
                initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellId] autorelease];
    }
    NSString *textLabel = kWineUndefinedLabel;
    
    switch (_list) {
        case kWineCategoryLocalFilter:
            switch ([indexPath row]) {
                case 0:
                    textLabel = @"Vino";
                    [cell setAccessoryType:
                            UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 1:
                    textLabel = @"Espumante";
                    /*[cell setAccessoryType:
                            UITableViewCellAccessoryDisclosureIndicator];*/
                    break;
                default:
                    break;
            }
            break;
        case kWineWinesLocalFilter:
            switch ([indexPath row]) {
                case 0:
                    textLabel = @"Blanco";
                    break;
                case 1:
                    textLabel = @"Rosado";
                    break;
                case 2:
                    textLabel = @"Tinto";
                    break;
                case 3:
                    textLabel = @"Todos";
                    break;
                default:
                    break;
            }
            break;
        case kWinePriceLocalFilter:
            switch ([indexPath row]) {
                case 0:
                    textLabel = @"Menos de S/. 50";
                    break;
                case 1:
                    textLabel = @"Entre S/. 50 y S/. 100";
                    break;
                case 2:
                    textLabel = @"Más de S/. 100";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [[cell textLabel] setText:textLabel];
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:17.]];
    [[cell textLabel] setText:textLabel];
    return cell;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *navController = [self navigationController];
    switch (_list) {
        case kWineCategoryLocalFilter:
            switch ([indexPath row]) {
                case 0: {
                    LocalFilteringListController *controller =
                            [[[LocalFilteringListController alloc]
                               initWithList:kWineWinesLocalFilter] autorelease];
                    
                    [navController pushViewController:controller
                            animated:YES];
                    break;
                }
                case 1:
                    [navController popViewControllerAnimated:YES];
                default:
                    break;
            }
            break;
        case kWineWinesLocalFilter: {
            UIViewController *filterController;
            
            for (UIViewController *controller in
                    [navController viewControllers]) {
                if ([controller isKindOfClass:[WineFilterController class]]) {
                    filterController = controller;
                    break;
                }
            }
            [navController popToViewController:filterController animated:YES];
            break;
        }
        case kWinePriceLocalFilter:
            [navController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}
@end