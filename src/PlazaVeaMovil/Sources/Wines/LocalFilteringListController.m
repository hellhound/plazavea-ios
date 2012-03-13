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
#pragma mark NSObject

- (void)dealloc
{
    _delegate = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *title = @"";
    
    switch (_list) {
        case kWineCategoryLocalFilter:
            title = kWineCategoriesLabel;
            break;
        case kWineWinesLocalFilter:
            title = kWineWinesLabel;
            break;
        case kWinePriceLocalFilter:
            title = kWinePricesLabel;
            break;
        default:
            break;
    }
    [[self tableView] setTableHeaderView:[self viewWithImageURL:nil
            title:title]];
}

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
        }
    }
    return self;
}

#pragma mark -
#pragma mark LocalFilteringListController

@synthesize list = _list, delegate = _delegate;

- (id)initWithList:(WineLocalFilteringListType)list
{
    if ((self = [self initWithStyle:UITableViewStylePlain]) != nil)
        _list = list;
    return self;
}

- (id)initWithList:(WineLocalFilteringListType)list
          delegate:(id<LocalFilteringListControllerDelegate>)delegate
{
    if ((self = [self initWithList:list]) != nil)
        _delegate = delegate;
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:nil] autorelease];
    
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
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth,
            [imageView frame].size.height + titleHeight + (margin * 2.));
    
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
                    textLabel = kWineWineLabel;
                    [cell setAccessoryType:
                            UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 1:
                    textLabel = kWineSparklingLabel;
                    break;
                default:
                    break;
            }
            break;
        case kWineWinesLocalFilter:
            switch ([indexPath row]) {
                case 0:
                    textLabel = kWineWhiteLabel;
                    break;
                case 1:
                    textLabel = kWineRoseLabel;
                    break;
                case 2:
                    textLabel = kWineRedLabel;
                    break;
                case 3:
                    textLabel = kWineAllLabel;
                    break;
                default:
                    break;
            }
            break;
        case kWinePriceLocalFilter:
            switch ([indexPath row]) {
                case 0:
                    textLabel = kWineLessThanLabel;
                    break;
                case 1:
                    textLabel = kWineBetweenLabel;
                    break;
                case 2:
                    textLabel = kWineMoreThanLabel;
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
    UIViewController *filterController;
    
    for (UIViewController *controller in
            [navController viewControllers]) {
        if ([controller isKindOfClass:[WineFilterController class]]) {
            filterController = controller;
            break;
        }
    }
    if ((_list == kWineCategoryLocalFilter) && ([indexPath row] == 0)) {
        LocalFilteringListController *controller =
                [[[LocalFilteringListController alloc] 
                    initWithList:kWineWinesLocalFilter delegate:
                    (id<LocalFilteringListControllerDelegate>)filterController]
                    autorelease];
        
        [navController pushViewController:controller animated:YES];
    } else {
        //[_delegate controller:self itemId:[NSNumber numberWithInt:100]];
        [_delegate controller:self didPickLocalItemId:[indexPath row]];
        [navController popToViewController:filterController animated:YES];
    }
}
@end