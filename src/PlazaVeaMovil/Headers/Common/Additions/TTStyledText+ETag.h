#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface TTStyledText (ETag)

- (void)stopLoadingImages;
- (void)loadImages;
- (void)reloadWithCachePolicy:(NSNumber *)cachePolicy;
@end
