#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Wines/WineInfoDataSource.h"

@interface WineInfoController: ReconnectableTableViewController
        <WineInfoDataSourceDelegate>
{
    NSString *_wineId;
}

- (id)initWithWineId:(NSString *)wineId;
@end