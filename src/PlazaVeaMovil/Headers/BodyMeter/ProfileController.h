#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <TSAlertView/TSAlertView.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@interface ProfileController: UITableViewController <TSAlertViewDelegate,
        UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSUserDefaults *_defaults;
    Profile *_profile;
    pickerIndex _pickerIndex;
    NSMutableArray *_pickerItems;
}
@property (nonatomic, retain) Profile *profile;
@end