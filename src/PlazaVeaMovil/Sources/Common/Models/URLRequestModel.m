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
    if (_isTryingCache) {
        [super didFailLoadWithError:error];
    } else {
        [self setIsTryingCache:YES];
        if ([self isLoading])
            [self cancel]; // just in case
        if (![self isLoaded])
            [self load:TTURLRequestCachePolicyDefault more:NO];
        [self didChange]; // show the cache content
    }
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
@end
