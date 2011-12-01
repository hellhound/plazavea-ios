#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Additions/UINavigationBar+Additions.h"

@implementation UINavigationBar(Additions)

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [(UIButton *)subView setTitleColor:color 
                    forState:state];
            [(UIButton *)subView setTitleShadowColor:[UIColor clearColor]
                    forState:state];
        }
    }
}
@end
