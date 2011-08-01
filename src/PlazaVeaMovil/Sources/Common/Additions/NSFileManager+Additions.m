#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/NSError+Additions.h"
#import "Common/Additions/NSFileManager+Additions.h"

@implementation NSFileManager (Additions)

#pragma mark -
#pragma mark NSFileManager (Additions)

- (NSURL *)appSupportDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *appSupportPath = nil;
    NSArray *paths = [fm URLsForDirectory:NSApplicationSupportDirectory
            inDomains:NSUserDomainMask];

    if ([paths count] > 0) {
        NSError *error = nil;

        appSupportPath = [paths objectAtIndex:0];
        if (![fm createDirectoryAtPath:[appSupportPath path]
                withIntermediateDirectories:YES attributes:nil error:&error]) {
            [error log];
            return nil;
        }
    }
    return appSupportPath;
}
@end
