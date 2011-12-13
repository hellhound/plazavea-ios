#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/NonEditableLauncherView.h"

@implementation NonEditableLauncherView

#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) != nil) {
        [_pager setHidesForSinglePage:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTLauncherView

- (void)editHoldTimer:(NSTimer *)timer
{
    _editHoldTimer = nil;
    // NO-OP
}
@end
