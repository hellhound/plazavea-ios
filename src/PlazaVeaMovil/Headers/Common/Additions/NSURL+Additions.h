#import <Foundation/Foundation.h>

@interface NSURL (Additions)

+ (BOOL)validateURL:(NSString *)candidateURL;

// Needed for pre iOS 4
- (NSURL *)URLByAppendingPathComponent:(NSString *)pathComponent;
@end
