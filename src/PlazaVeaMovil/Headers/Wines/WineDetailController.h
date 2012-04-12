#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

#import "Wines/Constants.h"
#import "Wines/WineDetailDataSource.h"

@interface WineDetailController: ReconnectableTableViewController
        <WineDetailDataSourceDelegate>
{
    WineDetailFromType _from;
    NSString *_wineId;
    NSString *_name;
    NSString *_imageURL;
}
@property (nonatomic, assign) WineDetailFromType from;
@property (nonatomic, retain) NSString *wineId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURL;

- (id)initWithWineId:(NSString *)wineId;
- (id)initWithWineId:(NSString *)wineId from:(NSString *)from;
- (void)showBigPicture;
@end