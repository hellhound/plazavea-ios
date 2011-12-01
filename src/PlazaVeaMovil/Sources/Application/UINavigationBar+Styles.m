#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Three20Style/Three20Style.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Additions/NSObject+SupersequentImplementation.h"
#import "Common/Additions/UINavigationBar+Additions.h"

#import "Application/UINavigationBar+Styles.h"

@implementation UINavigationBar(Styles)

- (void)setNeedsDisplay
{
    INVOKE_SUPERSEQUENT_NO_PARAMETERS();
    if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(textColor)])
        [self setTitleColor:[UIColor blackColor]
                forState:UIControlStateNormal];
}
@end
