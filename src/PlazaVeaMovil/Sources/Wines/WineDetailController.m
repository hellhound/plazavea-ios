#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WinePictureController.h"
#import "Wines/WineDetailController.h"

@implementation WineDetailController

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
    [self setDataSource:[[[WineDetailDataSource alloc] initWithWineId:_wineId
            delegate:self] autorelease]];
}

#pragma mark -
#pragma mark WineDetailController

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

- (void)showBigPicture
{
    [[TTNavigator navigator] openURLAction: [[TTURLAction
            actionWithURLPath:URL(kURLWinePictureCall, @"http:--restmocker.bitzeppelin.com-media-attachments-IMG_2501.jpg")] applyAnimated:YES]];
}

#pragma mark -
#pragma mark <WineDetailDataSourceDelegate>

- (void) dataSource:(WineDetailDataSource *)dataSource
      viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
@end