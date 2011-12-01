#import <Foundation/Foundation.h>

#import <Three20Style/TTStyleSheet.h>

#import "Common/Additions/TTStyleSheet+Additions.h"

@implementation TTStyleSheet(Additions)

#pragma mark -
#pragma mark TTStyleSheet (Additions)
+ (BOOL)hasStyleSheetForSelector:(SEL)selector
{
    return [[self globalStyleSheet] respondsToSelector:selector];
}
@end
