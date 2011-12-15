#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Three20Style/Three20Style.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Additions/NSObject+SupersequentImplementation.h"

#import "Application/UIToolbar+Styles.h"

@implementation UIToolbar(Styles)

- (void)layoutSubviews
{
    INVOKE_SUPERSEQUENT_NO_PARAMETERS();
    if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarTintColor)])
        [self setTintColor:(UIColor *)TTSTYLE(navigationBarTintColor)];
    for (id subView in self.subviews) {
        if ([subView isMemberOfClass:[UISegmentedControl class]]) {
            if ([TTStyleSheet
                    hasStyleSheetForSelector:@selector(navigationBarTintColor)])
            [subView setTintColor:(UIColor *)TTSTYLE(navigationBarTintColor)];
        }
    }
}
@end
