#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/UIDevice+Additions.h"

#define UIDEVICE_BASE_MAJOR_SYSTEM_VERSION 2
#define UIDEVICE_BASE_MINOR_SYSTEM_VERSION 1

static NSCharacterSet *kPunctuationCharacterSet;

@implementation UIDevice (Additions)

#pragma mark -
#pragma mark NSObject

+ (void)load
{
    kPunctuationCharacterSet = [NSCharacterSet punctuationCharacterSet];
}

#pragma mark -
#pragma mark UIDevice (Additions)

- (UIDeviceSystemVersion)deviceSystemVersion
{
    NSString *systemVersion = [self systemVersion];
    NSArray *versionComponents =
            [systemVersion componentsSeparatedByCharactersInSet:
                kPunctuationCharacterSet];

    if ([versionComponents count] == 0)
        // fallback to kSystemVersion3
        return kSystemVersion3;
    
    NSInteger majorVersion =
            [[versionComponents objectAtIndex:0] integerValue] -
                UIDEVICE_BASE_MAJOR_SYSTEM_VERSION;

    if (majorVersion < kSystemVersion3)
        // fallback to kSystemVersion3
        return kSystemVersion3;
    if (majorVersion == kSystemVersion3) {
        NSInteger minorVersion = 
                [[versionComponents objectAtIndex:0] integerValue];

        if (minorVersion > UIDEVICE_BASE_MINOR_SYSTEM_VERSION)
            // it's an iPad
            return kSystemVersion32;
    } 
    if (majorVersion > kSystemVersion5)
        // This code is too old!
        return kSystemVersion6andUp;
    return majorVersion;
}
@end
