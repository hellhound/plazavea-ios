#define INVOKE_SUPERSEQUENT(...) \
    ([self getImplementationOf:_cmd \
        after:impOfCallingMethod(self, _cmd)]) \
            (self, _cmd, __VA_ARGS__)

#define INVOKE_SUPERSEQUENT_NO_PARAMETERS() \
	([self getImplementationOf:_cmd \
		after:impOfCallingMethod(self, _cmd)]) \
			(self, _cmd)

@class NSObject;

@interface NSObject (SupersequentImplementation)

IMP impOfCallingMethod(id lookupObject, SEL selector);

- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip;
@end
