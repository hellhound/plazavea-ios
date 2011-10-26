#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/VIews/TableImageSubtitleItem.h"
#import "Common/Views/ImageCarouselItem.h"
#import "Common/Views/ImageCarouselItemCell.h"

static const CGSize kCarouselDefaultContentSize = {320., 100.};
static const CGFloat kCarouselPageControlHeight = 20.;
static const NSTimeInterval kCarouselAnimationDuration = 1.5;
static const NSTimeInterval kCarouselPromotionDuration = 6.;

@interface ImageCarouselItemCell ()

// It's only purpose is to retain every image view for being available to their
// delegate
@property (nonatomic, retain) NSMutableArray *imageViews;
@property (nonatomic, retain) NSMutableArray *loadedImageViews;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *defaultImageView;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;

+ (CGSize)scrollContentSizeForItem:(ImageCarouselItem *)item;
+ (CGSize)sizeForImageItem:(TableImageSubtitleItem *)item
              defaultImage:(UIImage *)globalDefaultImage
                     style:(TTStyle *)globalStyle;
@end

@implementation ImageCarouselItemCell

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_imageViews release];
    [_loadedImageViews release];
    [_scrollView release];
    [_pageControl release];
    [_defaultImageView release];
    [_activityIndicator release];
    [super dealloc];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    for (UIView *view in _imageViews) {
        UIPageControl *pageControl = [self pageControl];

        [view setBackgroundColor:[self backgroundColor]];
        [pageControl setCurrentPage:0]; // the first page
        [pageControl setNumberOfPages:0];
    }
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    UIScrollView *scrollView = [self scrollView];
    UIPageControl *pageControl = [self pageControl];
    CGRect scrollFrame = [self bounds];
    CGRect pageFrame;

    scrollFrame.size.height -= kCarouselPageControlHeight;
    pageFrame = CGRectMake(.0, scrollFrame.size.height, scrollFrame.size.width,
            kCarouselPageControlHeight);
    [scrollView setFrame:scrollFrame];
    [pageControl setFrame:pageFrame];
}

#pragma mark -
#pragma mark UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString*)identifier
{
    if ((self =
            [super initWithStyle:style reuseIdentifier:identifier]) != nil) {
        UIView *contentView = [self contentView];

        [contentView addSubview:[self scrollView]];
        [contentView addSubview:[self pageControl]];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object 
{
    return [self scrollContentSizeForItem:(ImageCarouselItem *)object].height +
            kCarouselPageControlHeight;
}

- (void)setObject:(id)object
{
    [super setObject:object];
    // Reset *ImageViews each time a new object is assign to the cell
    [self setImageViews:[NSMutableArray array]];
    [self setLoadedImageViews:[NSMutableArray array]];

    ImageCarouselItem *item = object;

    // ImageCarouselItemCell's properties
    NSMutableArray *imageViews = [self imageViews];
    UIScrollView *scrollView = [self scrollView];
    // ImageCarouselItem's properties
    UIImage *defaultImage = [item defaultImage];
    TTStyle *style = [item style];
    NSArray *imageItems = [item imageItems];

    // Configure each image view
    for (TableImageSubtitleItem *imageItem in imageItems) {
        CGSize imageSize = [ImageCarouselItemCell sizeForImageItem:imageItem
                defaultImage:defaultImage style:style];
        TTImageView *imageView = [[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0, imageSize.width,
                    imageSize.height)] autorelease];

        [imageView setDelegate:self];
        [imageView setUrlPath:[imageItem imageURL]];
        [imageView setDefaultImage:[imageItem defaultImage]];
        // We need to retain the image views somewhere before they are presented
        // in the scroll view
        [imageViews addObject:imageView];
    }
    if (defaultImage != nil) {
        // Configuring scrollView with the defualt imageView and activity
        // indicator
        UIActivityIndicatorView *activityIndicator = [self activityIndicator];

        [self setDefaultImageView:[[[UIImageView alloc] initWithImage:
                defaultImage] autorelease]];

        UIImageView *defaultImageView = [self defaultImageView];

        [activityIndicator setCenter:[defaultImageView center]];
        [activityIndicator startAnimating];
        [scrollView setContentSize:[defaultImageView frame].size];
        [scrollView addSubview:defaultImageView];
        [scrollView addSubview:activityIndicator];
    }
}

#pragma mark -
#pragma mark ImageCarouselItemCell (Private)

@synthesize imageViews = _imageViews, loadedImageViews = _loadedImageViews,
    defaultImageView = _defaultImageView;

+ (CGSize)scrollContentSizeForItem:(ImageCarouselItem *)item
{
    NSArray *imageItems = [item imageItems];
    NSUInteger imageCount = [imageItems count];
    TTStyle *style = [item style];
    // Doesn't matter if imageStyle is nil, that's the beauty of Objective-C!
    TTImageStyle *imageStyle = [style firstStyleOfClass:[TTImageStyle class]];

    if (imageStyle != nil) {
        CGSize styleSize = [imageStyle size];

        return CGSizeMake(styleSize.width * imageCount, styleSize.height);
    }

    UIImage *defaultImage = [item defaultImage];

    if (defaultImage != nil) {
        CGSize defaultSize = [defaultImage size];

        return CGSizeMake(defaultSize.width * imageCount, defaultSize.height);
    }

    // We assign a negative number to avoid complications with equals-comparing
    // inaccuracy
    CGSize cummulativeSize = CGSizeMake(-1., -1.);

    for (TableImageSubtitleItem *imageItem in imageItems) {
        CGSize imageSize = [self sizeForImageItem:imageItem defaultImage:nil
                style:nil];
        
        cummulativeSize.width += imageSize.width;
        if (imageSize.height > cummulativeSize.height)
            cummulativeSize.height = imageSize.height;
    }
    if (cummulativeSize.width < .0)
        cummulativeSize.width = kCarouselDefaultContentSize.width;
    if (cummulativeSize.height < .0)
        cummulativeSize.height = kCarouselDefaultContentSize.height;
    return cummulativeSize;
}

+ (CGSize)sizeForImageItem:(TableImageSubtitleItem *)item
              defaultImage:(UIImage *)globalDefaultImage
                     style:(TTStyle *)globalStyle
{
    // Doesn't matter if imageStyle is nil, that's the beauty of Objective-C!
    TTImageStyle *globalImageStyle =
            [globalStyle firstStyleOfClass:[TTImageStyle class]];

    if (globalImageStyle != nil)
        return [globalImageStyle size];

    // Doesn't matter if imageStyle is nil, that's the beauty of Objective-C!
    TTImageStyle *imageStyle =
            [[item imageStyle] firstStyleOfClass:[TTImageStyle class]];

    if (imageStyle != nil)
        return imageStyle.size;
    if (globalDefaultImage != nil)
        return globalDefaultImage.size;

    UIImage *defaultImage = [item defaultImage];

    if (defaultImage != nil)
        return defaultImage.size;

    UIImage *image = [[TTURLCache sharedCache] imageForURL:[item imageURL]];

    if (image != nil)
        return image.size;
    return kCarouselDefaultContentSize;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        // Configuring the scroll view
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setDelegate:self];
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setDirectionalLockEnabled:YES];
        [_scrollView setAlwaysBounceHorizontal:YES];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // Configuring the page control
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_pageControl setBackgroundColor:[UIColor lightGrayColor]];
        [_pageControl setCurrentPage:0];
    }
    return _pageControl;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:
                    UIActivityIndicatorViewStyleGray] autorelease];
        [_activityIndicator setHidesWhenStopped:YES];
    }
    return _activityIndicator;
}

#pragma mark -
#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *loadedImageViews = [self loadedImageViews];
    UIPageControl *pageControl = [self pageControl];
    CGPoint contentOffset = [scrollView contentOffset];
    NSInteger i = 0;

    // We use UIview given that TTImageView isn't a subclass of UIImageView and
    // defaultImageView is an instance of UIImageView
    for (UIView *view in loadedImageViews) {
        if ([view pointInside:
                    [scrollView convertPoint:contentOffset toView:view]
                withEvent:nil])
            [pageControl setCurrentPage:i]; 
        i++;
    }
}

#pragma mark -
#pragma mark <TTImageViewDelegate>

- (void)imageView:(TTImageView*)imageView didLoadImage:(UIImage*)image
{
    NSMutableArray *loadedImageViews = [self loadedImageViews];
    UIImageView *defaultImageView = [self defaultImageView];
    UIScrollView *scrollView = [self scrollView];
    UIActivityIndicatorView *activityIndicator = [self activityIndicator];
    UIPageControl *pageControl = [self pageControl];

    if ([defaultImageView superview] == scrollView) {
        // Remove defaultImageView and activityIndicator from scrollView
        [defaultImageView removeFromSuperview];
        [activityIndicator removeFromSuperview];
        [scrollView setContentSize:CGSizeZero];
    }

    CGSize contentSize = [scrollView contentSize];
    CGRect imageFrame = [imageView frame];
    CGFloat xOffset = contentSize.width;

    contentSize.width += imageFrame.size.width;
    [imageView setFrame:CGRectOffset(imageFrame, xOffset, .0)];
    // Configuring scrollView
    [scrollView setContentSize:contentSize];
    [scrollView addSubview:imageView];
    // Configuring pageControl
    [pageControl setNumberOfPages:[pageControl numberOfPages] + 1];
    // Add the TTImageView to loadedImageViews
    [loadedImageViews addObject:imageView];
}
@end
