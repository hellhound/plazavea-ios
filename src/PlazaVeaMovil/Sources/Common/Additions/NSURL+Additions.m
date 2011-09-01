#import <Foundation/Foundation.h>

#import "Common/Additions/NSURL+Additions.h"

static NSString *const kURLRegEx = 
        @"(http|https)://"
        @"((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";

@implementation NSURL (Additions)

#pragma mark -
#pragma mark NSURL (Additions)

+ (BOOL)validateURL:(NSString *)candidateURL
{
    NSPredicate *urlTest =
            [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kURLRegEx]; 

    return [urlTest evaluateWithObject:candidateURL];
}

// Needed for pre iOS 4
- (NSURL *)URLByAppendingPathComponent:(NSString *)pathComponent
{
    NSString *path = [self path];

    return [NSURL fileURLWithPath:
        [path stringByAppendingPathComponent:pathComponent]];
}
@end
