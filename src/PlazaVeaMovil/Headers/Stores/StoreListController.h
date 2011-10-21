#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

@interface StoreListController : ReconnectableTableViewController
{
    NSString *_subregionId;
}
@property (nonatomic, copy) NSString *subregionId;

- (id)initWithSubregionId:(NSString *)subregionId;
@end
