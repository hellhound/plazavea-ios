#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "Common/Additions/NSObject+SupersequentImplementation.h"

@implementation NSObject (SupersequentImplementation)

#pragma mark -
#pragma mark NSObject (SupersequentImplementation)

IMP impOfCallingMethod(id lookupObject, SEL selector)
{
    NSUInteger returnAddress = (NSUInteger)__builtin_return_address(0);
    NSUInteger closest = 0;
    // Iterate over the class and all superclasses
    Class currentClass = object_getClass(lookupObject);

    while (currentClass) {
        // Iterate over all instance methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        NSUInteger i;

        for (i = 0; i < methodCount; i++) {
            // Ignore methods with different selectors
            if (method_getName(methodList[i]) != selector)
                continue;
            
            // If this address is closer, use it instead
            NSUInteger address = (NSUInteger)method_getImplementation(methodList[i]);

            if (address < returnAddress && address > closest)
                closest = address;
        }
        free(methodList);
        currentClass = class_getSuperclass(currentClass);
    }
    return (IMP)closest;
}

// Lookup the next implementation of the given selector after the
// default one. Returns nil if no alternate implementation is found.
- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip
{
    BOOL found = NO;
    Class currentClass = object_getClass(self);

    while (currentClass) {
        // Get the list of methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);

        // Iterate over all methods
        for (NSUInteger i = 0; i < methodCount; i++) {
            // Look for the selector
            if (method_getName(methodList[i]) != lookup)
                continue;
            
            IMP implementation = method_getImplementation(methodList[i]);
            
            // Check if this is the "skip" implementation
            if (implementation == skip) {
                found = YES;
            } else if (found) {
                // Return the match.
                free(methodList);
                return implementation;
            }
        }
        // No match found. Traverse up through super class' methods.
        free(methodList);
        currentClass = class_getSuperclass(currentClass);
    }
    return nil;
}
@end
