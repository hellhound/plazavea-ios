#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/NSError+Additions.h"

static NSString *kLogFormat = @"ERROR: %li -- Domain: %@\n%@";

@implementation NSError (Additions)

#pragma mark -
#pragma mark NSError (Additions)

- (void)log
{
    NSLog(kLogFormat, [self code], [self domain], self);
}
@end
