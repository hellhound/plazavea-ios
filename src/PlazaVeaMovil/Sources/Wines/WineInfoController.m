#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WineInfoDataSource.h"
#import "Wines/WineInfoController.h"
#import "Wines/WineTableViewDelegate.h"

@implementation WineInfoController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_wineId release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[WineInfoDataSource alloc] initWithWineId:_wineId
            delegate:self] autorelease]];
}

- (id<UITableViewDelegate>)createDelegate
{
    return [[[WineTableViewDelegate alloc] initWithController:self]
            autorelease];
}

#pragma mark -
#pragma mark WIneInfoController

- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
        _wineId = [wineId copy];
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
#pragma mark <WineInfoDataSourceDelegate>

- (void) dataSource:(WineInfoDataSource *)dataSource
      viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end