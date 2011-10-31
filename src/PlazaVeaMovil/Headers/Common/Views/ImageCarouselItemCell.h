#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface ImageCarouselItemCell: TTTableLinkedItemCell
    <UIScrollViewDelegate, TTImageViewDelegate>
{
    NSMutableArray *_imageViews;
    NSMutableArray *_loadedImageViews;
    NSMutableArray *_shownEntries;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_defaultImageView;
    UIActivityIndicatorView *_activityIndicator;
    NSTimer *_animationIntervalTimer;
    BOOL _animating;
}
@end
