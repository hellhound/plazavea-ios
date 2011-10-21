#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    kSystemVersion3,
    kSystemVersion4,
    kSystemVersion5,
    kSystemVersion6andUp,
    kSystemVersion32 = 1000
} UIDeviceSystemVersion;

@interface UIDevice (Additions)

- (UIDeviceSystemVersion)deviceSystemVersion;
@end
