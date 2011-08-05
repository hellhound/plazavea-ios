#import <Foundation/Foundation.h>

#import "Common/Additions/NSString+Additions.h"

@implementation NSString (Additions)

#pragma mark -
#pragma mark NSString (Additions)

- (BOOL)isEmptyByTrimming
{
    static NSCharacterSet *whitespaceCharSet = nil;

    if (whitespaceCharSet == nil)
        whitespaceCharSet =
                [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];

    if([@"" isEqualToString:[self stringByTrimmingCharactersInSet:
            whitespaceCharSet]])
        return YES;
    return NO;
}
@end
