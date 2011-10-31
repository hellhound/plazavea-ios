#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/TableImageSubtitleItem.h"

@interface ImageCarouselItem: TTTableLinkedItem
{
    UIImage *_defaultImage;
    TTStyle *_style;
    NSArray *_imageItems;
}

// Cancels individual default images
@property (nonatomic, retain) UIImage *defaultImage;
// Cancels individual image styles
@property (nonatomic, retain) TTStyle *style;
// Array of TableImageSubtitleItem
@property (nonatomic, copy) NSArray *imageItems;

+ (id)itemWithImageItems:(NSArray *)imageItems;
@end
