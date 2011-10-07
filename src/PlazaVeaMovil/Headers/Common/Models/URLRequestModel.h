#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface URLRequestModel: TTURLRequestModel
{
    BOOL _isTryingCache;
}
@property (nonatomic, readonly) BOOL isTryingCache;

- (void)didFailLoadWithError:(NSError *)error tryAgain:(BOOL)tryAgain;
@end
