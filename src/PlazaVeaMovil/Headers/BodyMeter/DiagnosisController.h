#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface DiagnosisController: UITableViewController
{
    Profile *_profile;
    Diagnosis *_diagnosis;
    NSUserDefaults *_defaults;
}
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) Diagnosis *diagnosis;
@end