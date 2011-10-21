#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isEmptyByTrimming;
- (NSString *)stringByEscapingReservedRECharacterSet;
- (NSComparisonResult)localizedStandardCompare:(NSString *)comparee;
@end
