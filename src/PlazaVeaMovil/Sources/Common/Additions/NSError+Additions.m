#import <limits.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/NSError+Additions.h"

static NSString *kLogFormat = @"ERROR: %li -- Domain: %@\n%@";

@implementation NSError (Additions)

#pragma mark -
#pragma mark NSError (Additions)

- (void)log
{
    NSLog(kLogFormat, [self code], [self domain], self);
}

-(NSString *)HTTPRequestErrorDescriptionWithCodes:(NSDictionary *)codes;
{
#ifndef DEBUG
    // Should be autoreleasable, just as any convenience method, somebody else
    // should claim ownership over it
    NSString *errorMessage = @""; 
    NSString *domain = [self domain];

    // Check if it's a HTTP Request Error
    if ([domain isEqualToString:NSURLErrorDomain] ||
            [domain isEqualToString:NSPOSIXErrorDomain] ||
            [domain isEqualToString:APPLICATION_ERROR_DOMAIN]) {
        if (codes != nil) {
            NSInteger code = [self code];

            if (code < LONG_MAX)
                errorMessage = [codes objectForKey:
                        [NSNumber numberWithInteger:code]];
        }
        if (errorMessage == nil ||
                [errorMessage isKindOfClass:[NSNull class]] ||
                [errorMessage length] == 0) {
            NSString *localizedFailureReason = [self localizedFailureReason];
            NSString *localizedRecoverySuggestion =
                    [self localizedRecoverySuggestion];
            NSString *localizedDescription = [self localizedDescription];

            if (localizedFailureReason != nil && 
                    ![localizedFailureReason isKindOfClass:[NSNull class]] &&
                    [localizedFailureReason length] > 0)
                errorMessage = localizedFailureReason;
            else if (localizedRecoverySuggestion != nil &&
                    ![localizedRecoverySuggestion
                        isKindOfClass:[NSNull class]] &&
                    [localizedRecoverySuggestion length] > 0)
                errorMessage = localizedRecoverySuggestion;
            else
                errorMessage = localizedDescription;
        }
    }
    return errorMessage;
#else
    // Return a more descriptive error
    return [self description];
#endif
}

- (NSString *)HTTPRequestErrorDescription
{
    return [self HTTPRequestErrorDescriptionWithCodes:nil];
}
@end
