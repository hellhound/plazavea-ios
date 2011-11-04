#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    kSystemVersion3,
    kSystemVersion32,
    kSystemVersion4,
    kSystemVersion5,
    kSystemVersion6andUp,
} UIDeviceSystemVersion;

@interface UIDevice (Additions)

- (UIDeviceSystemVersion)deviceSystemVersion;
@end
