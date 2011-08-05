#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"

@interface EditableCellTableViewController (UITextFieldDelegate)

- (BOOL)testValue:(NSString *)value;
@end

@implementation EditableCellTableViewController (UITextFieldDelegate)

#pragma mark -
#pragma mark EditableCellTableViewController (UITextFieldDelegate)

- (BOOL)testValue:(NSString *)value
{
    if (value == nil || [value isEmptyByTrimming])
        return NO;
    return YES;
}

#pragma mark -
#pragma mark <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self testValue:[textField text]])
        return NO;
    // The user pressed "Done" button, so dismiss the keyboard and return
    [textField resignFirstResponder];
    return YES;
}
@end
