#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Common/Additions/UIDevice+Additions.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate (Defaults)

#pragma mark -
#pragma mark AppDelegate (Defaults)

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter != nil)
        return _dateFormatter;

    _dateFormatter = [[NSDateFormatter alloc] init];
    //[_dateFormatter setDateFormat:DATE_FORMAT];
    [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    if ([[UIDevice currentDevice] deviceSystemVersion] >= kSystemVersion4) {
        [_dateFormatter setDoesRelativeDateFormatting:YES];
    
        NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"es_PE"]
                autorelease];
    
        [_dateFormatter setLocale:locale];
    }
    return _dateFormatter;
}
@end
