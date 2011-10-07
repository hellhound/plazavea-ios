#import <Foundation/Foundation.h>

@interface NSError (Additions)

- (void)log;
- (NSString *)HTTPRequestErrorDescriptionWithCodes:(NSDictionary *)codes;
- (NSString *)HTTPRequestErrorDescription;
@end
