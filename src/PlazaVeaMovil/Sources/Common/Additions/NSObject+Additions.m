#import <objc/runtime.h>
#import <stdlib.h>
#import <Foundation/Foundation.h>

#import "Common/Additions/NSObject+Additions.h"

@implementation NSObject (Additions)

#pragma mark -
#pragma mark NSObject (Additions)

+ (NSData *)dataWithClassesCArray
{
    NSInteger numClasses;
    Class *classes = NULL;
    NSData *packagedClasses = nil;

    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        NSUInteger allocSize = sizeof(Class) * numClasses;

        classes = (Class *)malloc(allocSize);
        numClasses = objc_getClassList(classes, numClasses);
        packagedClasses = [NSData dataWithBytes:classes length:allocSize];
        free(classes);
    }
    return packagedClasses;
}

+ (NSSet *)setWithClassesConformingToProtocol:(Protocol *)protocol
{
    NSData *packagedClasses = [self dataWithClassesCArray];
    Class *classes = (Class *)[packagedClasses bytes];
    NSUInteger length = [packagedClasses length];
    NSMutableSet *classesThatCormform = [NSMutableSet setWithCapacity:length];
    NSUInteger i;

    for (i = 0; i < length; i++) {
        Class class = classes[i];
        
        // Doesn't always work! objc_getClassList() includes Class objects
        // that aren't NSObject subclasses
        //if ([class conformsToProtocol:protocol])
        if (class_conformsToProtocol(class, protocol))
            [classesThatCormform addObject:class];
    }
    return classesThatCormform;
}
@end
