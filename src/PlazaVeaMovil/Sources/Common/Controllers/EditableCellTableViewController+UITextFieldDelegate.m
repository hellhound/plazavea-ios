#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Models/Constants.h"
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Set the active text field for the table
    _activeTextField = textField;
}

- (BOOL)                textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string
{
    NSExpression *lhs = [NSExpression expressionForKeyPath:kOrderField];
    NSExpression *rhs = [NSExpression expressionForConstantValue:
            [NSNumber numberWithInteger:[textField tag]]];
    NSPredicate *predicate = [NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSEqualToPredicateOperatorType
            options:0];
    NSArray *objects = [[[self resultsController] fetchedObjects]
            filteredArrayUsingPredicate:predicate];

    if ([objects count] > 0) {
        NSManagedObject *object = [objects objectAtIndex:0];
        
        [self didChangeObject:object value:
                [[textField text] stringByReplacingCharactersInRange:range
                    withString:string]];
        [self fetchAndUpdate];
    }
    // Erase the active text field
    _activeTextField = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self testValue:[textField text]])
        return NO;
    // The user pressed "Done" button, so dismiss the keyboard and return
    [textField resignFirstResponder];
    return YES;
}
@end
