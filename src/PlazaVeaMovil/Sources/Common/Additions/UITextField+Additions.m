#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/UITextField+Additions.h"

@implementation UITextField (Additions)

#pragma mark -
#pragma mark UIResponder

- (BOOL)canResignFirstResponder
{
    NSString *value = [self text];

    if (value == nil || [value isEmptyByTrimming])
        return NO;
    return YES;
}
@end
