#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Wines/WineFilterController.h"
#import "Wines/FilteringListDataSource.h"
#import "Wines/FilteringListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation FilteringListController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    _delegate = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setVariableHeightRows:YES];
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
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[FilteringListDataSource alloc] initWithList:_list
        controller:self] autorelease]];
}

#pragma mark -
#pragma mark FilteringListController

@synthesize list = _list, delegate = _delegate;

- (id)initWithList:(NSString *)list
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        _list = [list intValue];
        NSString *title;
        switch (_list) {
            case kWineCountryFilter:
                title = kWineCountriesLabel;
                break;
            case kWineWineryFilter:
                title = kWineWineriesLabel;
                break;
            case kWineCategoryFilter:
                title = kWineCategoriesLabel;
                break;
            case kWineStrainFilter:
                title = kWineStrainsLabel;
                break;
            default:
                break;
        }
        [[self tableView] setTableHeaderView:[self viewWithImageURL:nil
                    title:title]];
    }
    return self;
}

- (id)initWithList:(NSString *)list
          delegate:(id<FilteringListControllerDelegate>)delegate
{
    if ((self = [self initWithList:list]) != nil) {
        _delegate = delegate;
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
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
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth, titleHeight +
            (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [headerView addSubview:titleLabel];
    
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}

- (void)back:(id)sender
{
    UINavigationController *navController = [self navigationController];
    UIViewController *filterController;
    
    for (UIViewController *controller in
            [navController viewControllers]) {
        if ([controller isKindOfClass:[WineFilterController class]]) {
            filterController = controller;
            _delegate = (id<FilteringListControllerDelegate>)controller;
            break;
        }
    }    
    //[_delegate controller:self itemId:[sender itemId]];
    [_delegate controller:self didPickItem:[sender extra]];
    [navController popToViewController:filterController animated:YES];
}
@end