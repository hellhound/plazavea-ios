#import <Foundation/Foundation.h>

#import "Common/Additions/NSURL+Additions.h"

@implementation NSURL (Additions)

#pragma mark -
#pragma mark NSURL (Additions)

// Needed for pre iOS 4
- (NSURL *)URLByAppendingPathComponent:(NSString *)pathComponent
{
    NSString *path = [self path];

    return [NSURL fileURLWithPath:
        [path stringByAppendingPathComponent:pathComponent]];
}
@end
