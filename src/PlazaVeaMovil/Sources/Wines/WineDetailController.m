#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/WinePictureController.h"
#import "Wines/WineDetailController.h"

@implementation WineDetailController

@synthesize wineId = _wineId, name = _name, imageURL = _imageURL, from = _from;

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_wineId release];
    [_name release];
    [_imageURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[WineDetailDataSource alloc] initWithWineId:_wineId
            delegate:self from:_from] autorelease]];
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

- (id)initWithWineId:(NSString *)wineId from:(NSString *)from
{
    if ((self = [self initWithWineId:wineId]) != nil) {
        _from = [from intValue];
    }
    return self;
}

- (void)showBigPicture
{
    [[TTNavigator navigator] openURLAction: [[TTURLAction actionWithURLPath:
            URL(kURLWinePictureCall, _imageURL, _name)]
                applyAnimated:YES]];
}

#pragma mark -
#pragma mark <WineDetailDataSourceDelegate>

- (void)dataSource:(WineDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}

- (void)dataSource:(WineDetailDataSource *)dataSource
      wineImageURL:(NSString *)imageURL
{
    _imageURL = [imageURL retain];
}

- (void)dataSource:(WineDetailDataSource *)dataSource wineName:(NSString *)name
{
    _name = [[name stringByReplacingOccurrencesOfString:@" " withString:@"-"]
            retain];
}
@end