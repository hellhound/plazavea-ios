#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface ImageCarouselItemCell: TTTableLinkedItemCell
    <UIScrollViewDelegate, TTImageViewDelegate>
{
    NSMutableArray *_imageViews;
    NSMutableArray *_loadedImageViews;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_defaultImageView;
    UIActivityIndicatorView *_activityIndicator;
}
@end
