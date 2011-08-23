#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTImageView+ETag.h"

@implementation TTImageView (ETag)

#pragma mark -
#pragma mark TTImageView (ETag)

- (void)reloadWithCachePolicy:(NSNumber *)cachePolicy
{
    // Fixed: Do not reload from the cache
    if (_request == nil && _urlPath != nil) {
        TTURLRequest* request =
                [TTURLRequest requestWithURL:_urlPath delegate:self];

        [cachePolicy retain];
        [request setCachePolicy:
                [request cachePolicy] | [cachePolicy unsignedIntegerValue]];
        [cachePolicy autorelease];
        [request setResponse:
                [[[TTURLImageResponse alloc] init] autorelease]];
        if (![request send]) {
            // Put the default image in place while waiting for the request
            // to load
            if (_defaultImage != nil && [self image] != _defaultImage) {
                //[self setImage:_defaultImage]; why this isn't this possible?!
                TT_RELEASE_SAFELY(_image);
                _image = [_defaultImage retain];
            }
        }
    }
}

- (void)reload
{
    // Fixed: Do not reload from the cache
    [self reloadWithCachePolicy:
            [NSNumber numberWithUnsignedInteger:TTURLRequestCachePolicyEtag]];
}

- (void)setUrlPath:(NSString *)urlPath
{
    // Fixed: Reload every URL, even if it's the same as before
    [self stopLoading];
    [_urlPath autorelease];
    _urlPath = [urlPath copy];
    if (_urlPath == nil || [_urlPath length] == 0) {
        // Setting the url path to an empty/nil path, so let's restore the
        // default image.
        TT_RELEASE_SAFELY(_image);
        _image = [_defaultImage retain];
    } else {
        [self reload];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error
{
    // Fixed: reload with default cache policy when there's no connection
    // available
    TT_RELEASE_SAFELY(_request);
    [self reloadWithCachePolicy:[NSNumber numberWithUnsignedInteger:
            TTURLRequestCachePolicyDefault]];
}
@end
