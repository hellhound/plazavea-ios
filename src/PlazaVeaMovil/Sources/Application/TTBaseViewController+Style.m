#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/TTBaseViewController+Style.h"

@implementation TTBaseViewController (Style)

#pragma mark -
#pragma mark TTBaseViewController (Style)

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setNavigationBarStyle:UIBarStyleDefault];
        if ([TTStyleSheet hasStyleSheetForSelector:@selector(statusBarStyle)])
            [self setStatusBarStyle:
                    (UIStatusBarStyle)TTSTYLEVAR(statusBarStyle)];
    }
    return self;
}
@end
