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

-(NSArray *)getParsedRows {
    NSMutableArray *rows = [NSMutableArray array];

    // Get newline character set
    NSMutableCharacterSet *newlineCharacterSet = 
        (id)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet];

    [newlineCharacterSet formIntersectionWithCharacterSet:[[
        NSCharacterSet whitespaceCharacterSet] invertedSet]];

    // Characters that are important to the parser
    NSMutableCharacterSet *importantCharactersSet = 
        (id)[NSMutableCharacterSet characterSetWithCharactersInString:@",\""];

    [importantCharactersSet formUnionWithCharacterSet:newlineCharacterSet];

    // Create scanner, and scan string
    NSScanner *scanner = [NSScanner scannerWithString:self];

    [scanner setCharactersToBeSkipped:nil];
    while ( ![scanner isAtEnd] ) {        
        BOOL insideQuotes = NO;
        BOOL finishedRow = NO;
        NSMutableArray *columns = [NSMutableArray arrayWithCapacity:10];
        NSMutableString *currentColumn = [NSMutableString string];

        while ( !finishedRow ) {
            NSString *tempString;
            if ( [scanner scanUpToCharactersFromSet:importantCharactersSet
                        intoString:&tempString] ) {
                [currentColumn appendString:tempString];
            }

            if ( [scanner isAtEnd] ) {
                if ( ![currentColumn isEqualToString:@""] )
                        [columns addObject:currentColumn];
                finishedRow = YES;
            }
            else if ( [scanner scanCharactersFromSet:newlineCharacterSet
                    intoString:&tempString] ) {
                if ( insideQuotes ) {
                    [currentColumn appendString:tempString];
                }
                else {
                    if ( ![currentColumn isEqualToString:@""] )
                            [columns addObject:currentColumn];
                    finishedRow = YES;
                }
            }
            else if ( [scanner scanString:@"\"" intoString:NULL] ) {
                if ( insideQuotes && 
                        [scanner scanString:@"\"" intoString:NULL] ) {
                    [currentColumn appendString:@"\""]; 
                }
                else {
                    insideQuotes = !insideQuotes;
                }
            }
            else if ( [scanner scanString:@"," intoString:NULL] ) {  
                if ( insideQuotes ) {
                    [currentColumn appendString:@","];
                }
                else {
                    // This is a column separating comma
                    [columns addObject:currentColumn];
                    currentColumn = [NSMutableString string];
                    [scanner scanCharactersFromSet:
                            [NSCharacterSet whitespaceCharacterSet]
                            intoString:NULL];
                }
            }
        }
        if ( [columns count] > 0 )
            [rows addObject:columns];
    }

    return rows;
}
@end
