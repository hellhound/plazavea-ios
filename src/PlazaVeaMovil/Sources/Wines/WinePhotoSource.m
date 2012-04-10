#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"
#import "Wines/Models.h"
#import "Wines/WinePhotoSource.h"

@implementation WinePhotoSource

@synthesize title = _title, photos =_photos;

#pragma mark -
#pragma mark WinePhotoSource

- (id)initWithTitle:(NSString *)title photos:(NSArray *)photos
{
    if ((self = [super init]) != nil) {
        _title = title;
        _photos = [photos copy];
                
        for (int i = 0; i < [_photos count]; i++) {
            WineLargeImage *image = (WineLargeImage *)[_photos objectAtIndex:i];
            
            [image retain];
            [image setPhotoSource:self];
            [image setIndex:i];
        }
    }
    return self;
}

#pragma mark -
#pragma mark <TTPhotoSource>

- (NSInteger)numberOfPhotos
{
    return [_photos count];
}

- (NSInteger)maxPhotoIndex
{
    return ([_photos count] - 1);
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [_photos count]) {
        return [_photos objectAtIndex:index];
    }
    return nil;
}
@end