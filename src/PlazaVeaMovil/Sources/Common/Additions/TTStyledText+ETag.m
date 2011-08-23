#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/NSObject+SupersequentImplementation.h"
#import "Common/Additions/TTStyledText+ETag.h"

@implementation TTStyledText (ETag)

#pragma mark -
#pragma mark TTStyledText (ETag)

- (void)stopLoadingImages
{
    INVOKE_SUPERSEQUENT_NO_PARAMETERS();
}

- (void)loadImages
{
    [self reloadWithCachePolicy:[NSNumber numberWithUnsignedInteger:
            TTURLRequestCachePolicyEtag]];
}

- (void)reloadWithCachePolicy:(NSNumber *)cachePolicy
{
    [self stopLoadingImages];
    if (_delegate != nil && _invalidImages != nil) {
        BOOL loadedSome = NO;

        for (TTStyledImageNode *imageNode in _invalidImages) {
            TTURLRequest *request =
                    [TTURLRequest requestWithURL:[imageNode URL] delegate:self];
            [request setUserInfo:imageNode];
            [request setResponse:
                    [[[TTURLImageResponse alloc] init] autorelease]];
            [request setCachePolicy:
                    [request cachePolicy] | [cachePolicy unsignedIntegerValue]];
            if (![request send]) {
                UIImage *defaultImage = [imageNode defaultImage];

                if (defaultImage != nil && [imageNode image] != defaultImage) {
                    loadedSome = YES;
                    [imageNode setImage:[imageNode defaultImage]];
                }
            }
        }
        TT_RELEASE_SAFELY(_invalidImages);
        if (loadedSome)
            [_delegate styledTextNeedsDisplay:self];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error
{
    // Fixed: reload with default cache policy when there's no connection
    // available
    [self reloadWithCachePolicy:[NSNumber numberWithUnsignedInteger:
            TTURLRequestCachePolicyDefault]];
}
@end
