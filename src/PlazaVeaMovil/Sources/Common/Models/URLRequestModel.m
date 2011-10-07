#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Models/URLRequestModel.h"

@interface URLRequestModel (Private)

- (void)setIsTryingCache:(BOOL)isTryingCache;
@end 

@implementation URLRequestModel

#pragma mark -
#pragma mark TTModel

- (void)didFailLoadWithError:(NSError *)error
{
    [self didFailLoadWithError:error tryAgain:YES];
}

- (void)didFinishLoad
{
    [self setIsTryingCache:NO];
    [super didFinishLoad];
}

- (void)endUpdates
{
    [self setIsTryingCache:NO];
    [super endUpdates];
}

#pragma mark -
#pragma mark URLRequestModel (Private)

- (void)setIsTryingCache:(BOOL)isTryingCache
{
    _isTryingCache = isTryingCache;
}

#pragma mark -
#pragma mark URLRequestModel (Public)

@synthesize isTryingCache = _isTryingCache;

- (void)didFailLoadWithError:(NSError *)error tryAgain:(BOOL)tryAgain
{
    if (_isTryingCache) {
        [super didFailLoadWithError:error];
    } else {
        [self setIsTryingCache:YES];
        if ([self isLoading])
            [self cancel]; // just in case
        if (tryAgain && ![self isLoaded])
            [self load:TTURLRequestCachePolicyDefault more:NO];
        if (!tryAgain) {
            [super didFailLoadWithError:error];
        } else if ([self isLoaded]) {
            [self didChange]; // show the cache content
        }
    }
}
@end
