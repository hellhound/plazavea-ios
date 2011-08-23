#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTURLImageResponse+ETag.h"

@implementation TTURLImageResponse (ETag)

#pragma mark -
#pragma mark TTURLImageResponse (ETag)

- (NSError *)request:(TTURLRequest *)request
     processResponse:(NSHTTPURLResponse *)response
                data:(id)data
{
    // Fixed: Using write-through instead of a wrongly implemented write-back
    // cache
    // This response is designed for NSData and UIImage objects, so if we get
    // anything else it's probably a mistake.
    TTDASSERT([data isKindOfClass:[UIImage class]] ||
            [data isKindOfClass:[NSData class]]);
    TTDASSERT(nil == _image);
    if ([data isKindOfClass:[UIImage class]]) {
        _image = [data retain];

    } else if ([data isKindOfClass:[NSData class]]) {
        UIImage* image = [UIImage imageWithData:data];

        if (nil != image) {
            if (!request.respondedFromCache) {
//              XXXjoe Working on option to scale down really large images to a
//              smaller size to save memory
//              if (image.size.width * image.size.height > (300*300)) {
//                  image = [image transformWidth:300 height:
//                        (image.size.height/image.size.width)*300.0 rotate:NO];
//                  NSData* data = UIImagePNGRepresentation(image);
//                  [[TTURLCache sharedCache] storeData:data
//                          forURL:request.URL];
//              }
                [[TTURLCache sharedCache] storeImage:image
                        forURL:request.urlPath];
            }
            _image = [image retain];
        } else {
            return [NSError errorWithDomain:kTTNetworkErrorDomain
                    code:kTTNetworkErrorCodeInvalidImage userInfo:nil];
        }
    }
    return nil;
}
@end
