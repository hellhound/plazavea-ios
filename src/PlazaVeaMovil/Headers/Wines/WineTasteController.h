#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Wines/WineTasteDataSource.h"

@interface WineTasteController: ReconnectableTableViewController
        <WineTasteDataSourceDelegate>
{
    NSString *_wineId;
}

- (id)initWithWineId:(NSString *)wineId;
@end