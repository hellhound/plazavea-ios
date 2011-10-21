#import <Foundation/Foundation.h>

#import "Common/Additions/strnatcmp.h"
#import "Common/Additions/NSString+Additions.h"

// []\^$.|?*+(){}

#define NSSTRING_STARTING_SQUARE_BRACKET @"["
#define NSSTRING_ENDING_SQUARE_BRACKET @"]"
#define NSSTRING_STARTING_CURL_BRACKET @"{"
#define NSSTRING_ENDING_CURL_BRACKET @"}"
#define NSSTRING_STARTING_PARENTHESES @"("
#define NSSTRING_ENDING_PARENTHESES @")"
#define NSSTRING_BACK_SLASH @"\\"
#define NSSTRING_CARET @"^"
#define NSSTRING_DOLLAR @"$"
#define NSSTRING_DOT @"."
#define NSSTRING_PIPE @"|"
#define NSSTRING_QUESTION_MARK @"?"
#define NSSTRING_STAR @"*"
#define NSSTRING_PLUS @"+"
#define NSSTRING_REPLACE(original, replacement) \
        [original stringByReplacingOccurrencesOfString:replacement \
            withString:NSSTRING_BACK_SLASH replacement]

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

- (NSString *)stringByEscapingReservedRECharacterSet
{
    NSString *result;

    // back slash should be treated first
    result = NSSTRING_REPLACE(self, NSSTRING_BACK_SLASH);
    result = NSSTRING_REPLACE(result, NSSTRING_STARTING_SQUARE_BRACKET);
    result = NSSTRING_REPLACE(result, NSSTRING_ENDING_SQUARE_BRACKET);
    result = NSSTRING_REPLACE(result, NSSTRING_STARTING_CURL_BRACKET);
    result = NSSTRING_REPLACE(result, NSSTRING_ENDING_CURL_BRACKET);
    result = NSSTRING_REPLACE(result, NSSTRING_STARTING_PARENTHESES);
    result = NSSTRING_REPLACE(result, NSSTRING_ENDING_PARENTHESES);
    result = NSSTRING_REPLACE(result, NSSTRING_CARET);
    result = NSSTRING_REPLACE(result, NSSTRING_DOLLAR);
    result = NSSTRING_REPLACE(result, NSSTRING_DOT);
    result = NSSTRING_REPLACE(result, NSSTRING_PIPE);
    result = NSSTRING_REPLACE(result, NSSTRING_QUESTION_MARK);
    result = NSSTRING_REPLACE(result, NSSTRING_STAR);
    result = NSSTRING_REPLACE(result, NSSTRING_PLUS);
    return result;
}

- (NSComparisonResult)localizedStandardCompare:(NSString *)comparee
{
    return (NSComparisonResult)strnatcasecmp(
            [self cStringUsingEncoding:NSUTF8StringEncoding],
            [comparee cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
