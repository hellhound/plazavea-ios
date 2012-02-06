#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface RecomendationsController: UITableViewController
{
    NSString *_recomendations;
}
@property (nonatomic, retain) NSString *recomendations;
- (id)initWithResult:(NSString *)result;
@end