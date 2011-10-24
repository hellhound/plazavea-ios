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
@property (nonatomic, retain) NSMutableArray *mutableImageViews;
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
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    for (UIView *view in _imageViews) {
        [view setBackgroundColor:[self backgroundColor]];
        [[self pageControl] setCurrentPage:0]; // the first page
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
    [self setMutableImageViews:[NSMutableArray array]];

    ImageCarouselItem *item = object;

    // ImageCarouselItemCell's properties
    NSMutableArray *imageViews = [self mutableImageViews];
    UIScrollView *scrollView = [self scrollView];
    // ImageCarouselItem's properties
    UIImage *defaultImage = [item defaultImage];
    TTStyle *style = [item style];
    NSArray *imageItems = [item imageItems];

    // Configuring imageViews
    for (TableImageSubtitleItem *imageItem in imageItems) {
        CGSize imageSize = [ImageCarouselItemCell sizeForImageItem:imageItem
                defaultImage:defaultImage style:style];
        TTImageView *imageView = [[[TTImageView alloc] initWithFrame:
                CGRectMake(.0, .0, imageSize.width,
                    imageSize.height)] autorelease];

        [imageView setDelegate:self];
        [imageView setUrlPath:[imageItem imageURL]];
        [imageView setDefaultImage:[imageItem defaultImage]];
        // Add the TTImageView to imageViews
        [imageViews addObject:imageView];
    }
    if (defaultImage != nil) {
        // Configuring scrollView with the defualt imageView and activity
        // indicator
        UIActivityIndicatorView *activityIndicator = [self activityIndicator];

        [self setDefaultImageView:[[[TTImageView alloc] initWithImage:
                defaultImage] autorelease]];

        UIImageView *defaultImageView = [self defaultImageView];

        [activityIndicator setCenter:[defaultImageView center]];
        [scrollView setContentSize:[defaultImageView frame].size];
        [scrollView addSubview:defaultImageView];
        [scrollView addSubview:activityIndicator];
    }
}

#pragma mark -
#pragma mark ImageCarouselItemCell (Private)

@synthesize mutableImageViews = _imageViews,
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
#pragma mark ImageCarouselItemCell

- (NSArray *)imageViews
{
    return [self mutableImageViews];
}

#pragma mark -
#pragma mark <TTImageViewDelegate>

- (void)imageView:(TTImageView*)imageView didLoadImage:(UIImage*)image
{
    /*
    // Configuring scrollView
    //[scrollView setContentSize:
    //          [ImageCarouselItemCell scrollContentSizeForItem:item]];
    // Setting content's height to 1 http://j.mp/pz0KcZ
    [scrollView setContentSize:CGSizeMake(
            [ImageCarouselItemCell scrollContentSizeForItem:item].width, 1.)];
    // Configuring the page control
    [pageControl setNumberOfPages:[imageItems count]];
    */
}
@end
