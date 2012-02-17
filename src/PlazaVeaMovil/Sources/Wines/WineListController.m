#import <Foundation/Foundation.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WineListDataSource.h"
#import "Wines/WineTableViewDelegate.h"
#import "Wines/WineListController.h"

@implementation WineListController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_categoryId release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kWineListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[WineListDataSource alloc]
            initWithCategoryId:_categoryId delegate:self] autorelease]];
}

- (id<UITableViewDelegate>)createDelegate
{
    return [[[WineTableViewDelegate alloc] initWithController:self]
            autorelease];
}

#pragma mark -
#pragma mark StoreListController (Public)

@synthesize categoryId = _categoryId;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        _categoryId = [categoryId copy];
        // Conf nav bar
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
#pragma mark <WineListDataSourceDelegate>

- (void)dataSource:(WineListDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end