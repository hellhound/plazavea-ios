#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@class LinkableScrollView;

@protocol LinkableScrollViewDelegate <UIScrollViewDelegate>

- (void)scrollViewDidTapped:(UITouch *)touch withEvent:(UIEvent *)event;
@end

@interface LinkableScrollView: UIScrollView
@end

@interface ImageCarouselItemCell: TTTableLinkedItemCell
    <UIScrollViewDelegate, TTImageViewDelegate, LinkableScrollViewDelegate>
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
