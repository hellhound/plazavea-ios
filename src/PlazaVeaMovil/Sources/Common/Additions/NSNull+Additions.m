#import <Foundation/Foundation.h>

#import "Common/Additions/NSNull+Additions.h"

@implementation NSNull (Additions)

#pragma mark -
#pragma mark NSNull (Additions)

+ (id)nullOrObject:(id)object
{
    return object != nil ? object : (id)[NSNull null];
}
@end
