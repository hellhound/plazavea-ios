#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface ProfileController: UITableViewController
{
    NSUserDefaults *_defaults;
    Profile *_profile;
    NSNumber *_idealWeight;
}
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) NSNumber *idealWeight;
@end