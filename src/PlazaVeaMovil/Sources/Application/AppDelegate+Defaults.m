#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate (Defaults)

#pragma mark -
#pragma mark AppDelegate (Defaults)

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter != nil)
        return _dateFormatter;

    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:DATE_FORMAT];
    return _dateFormatter;
}
@end
