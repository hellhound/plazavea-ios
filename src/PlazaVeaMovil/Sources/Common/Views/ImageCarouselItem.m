#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/ImageCarouselItem.h"

static NSString *const kDefaultImageKey = @"defaultImage";
static NSString *const kStyleKey = @"style";
static NSString *const kImageItemsKey = @"imageItems";

@implementation ImageCarouselItem

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_defaultImage release];
    [_style release];
    [_imageItems release];
    [super dealloc];
}

#pragma mark -
#pragma mark ImageCarouselItem (Public)

@synthesize defaultImage = _defaultImage, style = _style,
    imageItems = _imageItems;

+ (id)itemWithImageItems:(NSArray *)imageItems
{
    ImageCarouselItem *item = [[[self alloc] init] autorelease];

    [item setImageItems:imageItems];
    return item;
}

#pragma mark -
#pragma mark <NSCoding>

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setDefaultImage:[decoder decodeObjectForKey:kDefaultImageKey]];
        [self setStyle:[decoder decodeObjectForKey:kStyleKey]];
        [self setImageItems:[decoder decodeObjectForKey:kImageItemsKey]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    if (_defaultImage != nil)
        [encoder encodeObject:_defaultImage forKey:kDefaultImageKey];
    if (_style != nil)
        [encoder encodeObject:_style forKey:kStyleKey];
    if (_imageItems != nil)
        [encoder encodeObject:_imageItems forKey:kImageItemsKey];
}
@end
