#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/NSError+Additions.h"
#import "Common/Additions/NSFileManager+Additions.h"

@implementation NSFileManager (Additions)

#pragma mark -
#pragma mark NSFileManager (Additions)

- (NSURL *)appSupportDirectory
{
    /*
     * Not working on pre iOS 4
     *
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
    */
    NSString *appSupportPath = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
            NSApplicationSupportDirectory, NSUserDomainMask, YES);

    if ([paths count] > 0) {
        NSError *error = nil;

        appSupportPath = [paths objectAtIndex:0];
        if (![[NSFileManager defaultManager]
                createDirectoryAtPath:appSupportPath
                withIntermediateDirectories:YES attributes:nil error:&error]) {
            [error log];
            return nil;
        }
    }
    return [NSURL fileURLWithPath:appSupportPath];

}
@end
