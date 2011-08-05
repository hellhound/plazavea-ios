#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"

@interface EditableCellTableViewController (UITextFieldDelegate)
@end

@implementation EditableCellTableViewController (UITextFieldDelegate)

#pragma mark -
#pragma mark <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
@end
