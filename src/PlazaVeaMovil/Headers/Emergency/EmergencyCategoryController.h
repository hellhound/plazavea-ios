#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "Emergency/Models.h"

@interface EmergencyCategoryController : EditableTableViewController
{
    EmergencyCategory *_emergencyCategory;
}
- (void)loadCSV:(NSString *)csvFilePath;
@property (nonatomic, retain) EmergencyCategory *emergencyCategory;

@end
