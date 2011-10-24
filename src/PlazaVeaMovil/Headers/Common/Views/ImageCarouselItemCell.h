#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface ImageCarouselItemCell: TTTableLinkedItemCell <TTImageViewDelegate>
{
    NSMutableArray *_imageViews;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_defaultImageView;
    UIActivityIndicatorView *_activityIndicator;
}
@property (nonatomic, readonly) NSArray *imageViews;
@end
