#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#import "Common/Additions/NSMutableArray+Additions.h"

// No-ops for non-retaining objects.
static const void *retainNoOp(
        CFAllocatorRef allocator, const void *value) { return value; }
static void releaseNoOp(CFAllocatorRef allocator, const void *value) { }

@implementation NSMutableArray (Additions)

#pragma mark - 
#pragma mark NSMutableArray (Additions)

+ (NSMutableArray *)nonRetainingArray
{
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = retainNoOp;
    callbacks.release = releaseNoOp;
    return (NSMutableArray *)CFArrayCreateMutable(nil, 0, &callbacks);
}
@end
