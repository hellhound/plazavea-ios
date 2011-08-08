#import <Foundation/Foundation.h>

@interface NSObject (Additions)

+ (NSData *)dataWithClassesCArray;
+ (NSSet *)setWithClassesConformingToProtocol:(Protocol *)protocol;
@end
