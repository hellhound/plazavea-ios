#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Constants.h"
#import "Stores/Constants.h"
#import "Stores/StoresTableViewDelegate.h"
#import "Stores/StoreDetailController.h"

@interface StoreDetailController()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) UILabel *storeLabel;
@end

@implementation StoreDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_storeId release];
    [_headerView release];
    [_titleLabel release];
    [_imageView release];
    [_storeLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)loadView
{
    [super loadView];
    [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if ([self toolbarItems] != nil) {
        for (UIBarButtonItem *item in [self toolbarItems]) {
            if ([[item customView] isKindOfClass:[UISegmentedControl class]]) {
                [(UISegmentedControl *)[item customView] addTarget:self
                        action:@selector(switchControllers:)
                            forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    return navItem;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[StoreDetailDataSource alloc]
            initWithStoreId:_storeId delegate:self] autorelease]];
}

- (id<UITableViewDelegate>)createDelegate {
    return [[[StoresTableViewDelegate alloc] initWithController:self]
            autorelease];
}

#pragma mark -
#pragma mark StoreDetailController (Private)

@synthesize headerView = _headerView, titleLabel = _titleLabel,
    imageView = _imageView, storeLabel = _storeLabel;

- (id)initWithStoreId:(NSString *)storeId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        _storeId = [storeId copy];

        [self setTableViewStyle:UITableViewStyleGrouped];
        [self setVariableHeightRows:YES];
        [[self tableView] setBackgroundColor:[UIColor
                colorWithWhite:kStoreDetailBackground alpha:1.]];
    }
    return self;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kStoreSegmentedControlIndexMapButon:
            [self setSegmentIndex:kStoreSegmentedControlIndexListButton];
            [[TTNavigator navigator] openURLAction:[[TTURLAction
                    actionWithURLPath:URL(kURLStoreDetailMapCall, _storeId, 
                        kStoreListTitle)] applyAnimated:YES]];
            break;
        case kStoreSegmentedControlIndexListButton:
            [self dismissModalViewControllerAnimated:YES];
            break;
    }
}

#pragma mark -
#pragma mark <StoreDetailDataSourceDelegate>

- (void)dataSource:(StoreDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end
