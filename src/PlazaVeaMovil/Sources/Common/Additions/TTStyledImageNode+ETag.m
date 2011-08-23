#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyledImageNode+ETag.h"

@implementation TTStyledImageNode (ETag)

#pragma mark -
#pragma mark TTStyledImageNode (ETag)

- (void)setURL:(NSString *)URL
{
    // Fixed: Reload every URL, even if it's the same as before
    [_URL autorelease];
    _URL = [URL retain];
    [self setImage:nil];
}
@end
