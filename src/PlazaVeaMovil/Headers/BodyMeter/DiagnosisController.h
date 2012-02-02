#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface DiagnosisController: UITableViewController
{
    Profile *_profile;
    NSNumber *_idealWeight;
    NSUserDefaults *_defaults;
}
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) NSNumber *idealWeight;
@end