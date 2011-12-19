#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/ImageCarouselItem.h"
#import "Common/Views/ImageCarouselItemCell.h"

static const CGSize kCarouselDefaultContentSize = {320., 100.};
static const CGFloat kCarouselPageControlHeight = 20.;
static const NSTimeInterval kCarouselAnimationDuration = 2.;
static const NSTimeInterval kCarouselDelayBetweenAnimations = 5.;
// Animtion identifier
static NSString *const kCarouselAutoscrollKey = @"carouselAutoscrollKey";

@interface CircularScrollEntry: NSObject
{
    TTImageView *_imageView;
    NSInteger _index;
}
@property (nonatomic, retain) TTImageView *imageView; 
@property (nonatomic, assign) NSInteger index;

+ (id)entryWithImageView:(TTImageView *)imageView index:(NSInteger)index;
@end

@implementation CircularScrollEntry

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_imageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark CircularScrollEntry (Public)

@synthesize imageView = _imageView, index = _index;

+ (id)entryWithImageView:(TTImageView *)imageView index:(NSInteger)index
{
    CircularScrollEntry *entry =
            [[[CircularScrollEntry alloc] init] autorelease];

    [entry setImageView:imageView];
    [entry setIndex:index];
    return entry;
}
@end

@implementation LinkableScrollView

#pragma mark -
#pragma mark UIRespoonder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] != 1)
        [super touchesEnded:touches withEvent:event];

    id<LinkableScrollViewDelegate> delegate =
            (id<LinkableScrollViewDelegate>)[self delegate];

    if ([delegate conformsToProtocol:@protocol(LinkableScrollViewDelegate)])
        [delegate scrollViewDidTapped:(UITouch *)[touches anyObject]
            withEvent:event];
}
@end

@interface ImageCarouselItemCell ()

// It's only purpose is to retain every image view for being available to their
// delegate
@property (nonatomic, retain) NSMutableArray *imageViews;
@property (nonatomic, retain) NSMutableArray *loadedImageViews;
// collection of CircularScrollEntry instances holding the image view's
// loadedImageViews' index and the TTImageView instances as its properties
@property (nonatomic, retain) NSMutableArray *shownEntries;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *defaultImageView;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSTimer *animationIntervalTimer;
@property (nonatomic, assign, getter=isAnimating) BOOL animating;
@property (nonatomic, readonly) NSInteger currentIndex;
@property (nonatomic, readonly) NSInteger previousIndex;
@property (nonatomic, readonly) NSInteger nextIndex;

+ (CGSize)scrollContentSizeForItem:(ImageCarouselItem *)item;
+ (CGSize)sizeForImageItem:(TableImageSubtitleItem *)item
              defaultImage:(UIImage *)globalDefaultImage
                     style:(TTStyle *)globalStyle;

- (void)cleanScrollView;
- (void)cleanImageViews;
- (void)createCircularIllusion;
@end

@interface ImageCarouselItemCell (EventHandlers)

- (void)refreshPageControlHandler:(UIPageControl *)pageControl;
@end

@interface ImageCarouselItemCell (Autoscrolling)

- (void)scheduleAutoscrolling;
- (void)unscheduleAutoscrolling;
- (void)cancelAutoscrolling;
- (void)animateToShowEntryIndex:(NSInteger)index;
- (void)animateAutoscrolling;
- (void)autoscrollingDidStop:(NSString *)animationId
                    finished:(NSNumber *)finished
                     context:(void *)context;
@end

@implementation ImageCarouselItemCell

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [self cleanImageViews];
    [self unscheduleAutoscrolling];
    [_imageViews release];
    [_loadedImageViews release];
    [_shownEntries release];
    [_scrollView release];
    [_pageControl release];
    [_defaultImageView release];
    [_activityIndicator release];
    [_animationIntervalTimer release];
    [super dealloc];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    for (UIView *view in [self imageViews]) {
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

- (void)removeFromSuperview
{
    [self cleanImageViews];
    [super removeFromSuperview];
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
    // Reset *ImageViews and shown entries each time a new object is assign to
    // the cell
    [self setImageViews:[NSMutableArray array]];
    [self setLoadedImageViews:[NSMutableArray array]];
    [self setShownEntries:[NSMutableArray array]];

    ImageCarouselItem *item = object;

    // ImageCarouselItemCell's properties
    NSMutableArray *imageViews = [self imageViews];
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
        UIScrollView *scrollView = [self scrollView];
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
    shownEntries = _shownEntries, defaultImageView = _defaultImageView,
    animationIntervalTimer = _animationIntervalTimer, animating = _animating;

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
        _scrollView = [[LinkableScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setDelegate:self];
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
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
        [_pageControl addTarget:self
                action:@selector(refreshPageControlHandler:)
                forControlEvents:UIControlEventValueChanged];
        [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_pageControl setBackgroundColor:[UIColor lightGrayColor]];
        [_pageControl setCurrentPage:0];
    }
    return _pageControl;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:
                    UIActivityIndicatorViewStyleGray];
        [_activityIndicator setHidesWhenStopped:YES];
    }
    return _activityIndicator;
}

- (NSInteger)currentIndex
{
    CGPoint contentOffset = [[self scrollView] contentOffset];
    NSArray *shownEntries = [self shownEntries];
    UIScrollView *scrollView = [self scrollView];
    NSInteger currentPage = 0;

    for (CircularScrollEntry *entry in shownEntries) {
        TTImageView *imageView = [entry imageView];

        if ([imageView pointInside:
                    [scrollView convertPoint:contentOffset toView:imageView]
                withEvent:nil]) {
            currentPage = [entry index];
            break;
        }
    }
    return currentPage;
}

- (NSInteger)previousIndex
{
    NSInteger loadedCount = (NSInteger)[[self loadedImageViews] count];
    NSInteger currentIndex = [self currentIndex];

    if (loadedCount == 0)
        return 0;
    return currentIndex == 0 ? loadedCount - 1 : currentIndex - 1;
}

- (NSInteger)nextIndex
{
    NSInteger loadedCount = (NSInteger)[[self loadedImageViews] count];
    NSInteger currentIndex = [self currentIndex];

    if (loadedCount == 0)
        return 0;
    return currentIndex == loadedCount - 1 ? 0 : currentIndex + 1;
}

- (void)cleanImageViews
{
    for (TTImageView *imageView in _imageViews)
        [imageView setDelegate:nil];
}

- (void)cleanScrollView
{
    NSMutableArray *shownEntries = [self shownEntries];
    UIImageView *defaultImageView = [self defaultImageView];
    UIActivityIndicatorView *activityIndicator = [self activityIndicator];

    // Remove defaultImageView and activityIndicator from scrollView
    [defaultImageView removeFromSuperview];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    // Remove shown image views
    for (CircularScrollEntry *entry in shownEntries)
        [[entry imageView] removeFromSuperview];
    [[self scrollView] setContentSize:CGSizeZero];
    // Clear all entries
    [shownEntries removeAllObjects];
}

- (void)createCircularIllusion
{
    // TODO createCircularIllusion needs cleansing
    NSArray *loadedImageViews = [self loadedImageViews];
    NSUInteger loadedCount = [loadedImageViews count];

    if (loadedCount < 1)
        return;

    NSMutableArray *shownEntries = [self shownEntries];
    NSInteger currentIndex = [self currentIndex];
    NSInteger previousIndex = [self previousIndex];
    NSInteger nextIndex = [self nextIndex];
    UIScrollView *scrollView = [self scrollView];
    TTImageView *imageView;
    CircularScrollEntry *entry;

    // Clear all entries before messing with shownEntries
    [self cleanScrollView];
    if (loadedCount > 1) {
        //
        // Previous-image view configuration
        //
        // Fetch the previous-image view from the array of loaded ones
        imageView = [loadedImageViews objectAtIndex:previousIndex];
        // Create an entry for the previous-image view
        entry = [CircularScrollEntry entryWithImageView:imageView
                index:previousIndex];
        // Add the previous-image view before the current one
        [shownEntries insertObject:entry atIndex:0];
    }
    //
    // Current-image view configuration
    //
    // Add the currently shown entry
    imageView = [loadedImageViews objectAtIndex:currentIndex];
    entry = [CircularScrollEntry entryWithImageView:imageView
            index:currentIndex];
    [shownEntries addObject:entry];
    if (loadedCount > 1) {
        //
        // Next-image view configuration
        //
        // Fetch the next-image view from the array of loaded ones
        imageView = [loadedImageViews objectAtIndex:nextIndex];
        // Create an entry for the next-image view
        entry = [CircularScrollEntry entryWithImageView:imageView
                index:nextIndex];
        // Add the next-image view after the current one
        [shownEntries addObject:entry];
    }
    //
    // Configuring scrollView's
    //
    CGFloat xOffset = .0;
    CGSize scrollSize = [scrollView frame].size;
    CGSize contentSize = scrollSize;

    contentSize.width = xOffset;

    for (CircularScrollEntry *entry in shownEntries) {
        TTImageView *imageView = [entry imageView];
        CGSize imageSize = [imageView bounds].size;

        if (imageSize.width > imageSize.height) {
            imageSize.width = scrollSize.width;
            imageSize.height *= imageSize.width / scrollSize.width;
        } else {
            imageSize.height = scrollSize.height;
            imageSize.width *= imageSize.height / scrollSize.height;
        }
        [imageView setFrame:
                CGRectMake(xOffset, .0, imageSize.width, imageSize.height)];
        [scrollView addSubview:imageView];
        contentSize.width = xOffset += imageSize.width;
    }
    [scrollView setContentSize:contentSize];
    if (loadedCount > 1) {
        imageView = [(CircularScrollEntry *)
                [[self shownEntries] objectAtIndex:1] imageView];

        [scrollView setContentOffset:[imageView frame].origin];
    }
}

#pragma mark -
#pragma mark ImageCarouselItemCell (EventHandlers)

- (void)refreshPageControlHandler:(UIPageControl *)pageControl
{
    if ([self isAnimating])
        return;
    [self unscheduleAutoscrolling];

    // Decide the direction in which we'll be animating the scrollView
    NSUInteger newShownIndex =
            [[self pageControl] currentPage] > [self currentIndex] ?
                [self nextIndex] : [self previousIndex];

    [self animateToShowEntryIndex:newShownIndex];
    [self scheduleAutoscrolling];
}

#pragma mark -
#pragma mark ImageCarouselItemCell (Autoscrolling)

- (void)scheduleAutoscrolling
{
    [self setAnimationIntervalTimer:
            [NSTimer timerWithTimeInterval:kCarouselDelayBetweenAnimations
                target:self selector:@selector(animateAutoscrolling)
                userInfo:nil repeats:YES]];
    [[NSRunLoop mainRunLoop] addTimer:[self animationIntervalTimer]
            forMode:NSDefaultRunLoopMode];
}

- (void)unscheduleAutoscrolling
{
    [self cancelAutoscrolling];
    [[self animationIntervalTimer] invalidate];
}

- (void)cancelAutoscrolling
{
    if ([self isAnimating])
        [[[self scrollView] layer] removeAnimationForKey:
                kCarouselAutoscrollKey];
}

- (void)animateToShowEntryIndex:(NSInteger)index
{
    NSArray *shownEntries = [self shownEntries];

    if ([shownEntries count] < 2)
        return;

    TTImageView *imageView = [[self loadedImageViews] objectAtIndex:index];

    [self setAnimating:YES];
    [UIView beginAnimations:kCarouselAutoscrollKey context:NULL];
    [UIView setAnimationDuration:kCarouselAnimationDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:
            @selector(autoscrollingDidStop:finished:context:)];
    [[self scrollView] setContentOffset:[imageView frame].origin];
    [UIView commitAnimations];
}

- (void)animateAutoscrolling
{
    [self animateToShowEntryIndex:[self nextIndex]];
}

- (void)autoscrollingDidStop:(NSString *)animationId
                    finished:(NSNumber *)finished
                     context:(void *)context
{
    [self setAnimating:NO];
    [self createCircularIllusion];
    [[self pageControl] setCurrentPage:[self currentIndex]]; 
}

#pragma mark -
#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self unscheduleAutoscrolling];
    if (![scrollView isDragging]) {
        [self createCircularIllusion];
        [[self pageControl] setCurrentPage:[self currentIndex]]; 
    }
    [self scheduleAutoscrolling];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self unscheduleAutoscrolling];
    [self createCircularIllusion];
    [[self pageControl] setCurrentPage:[self currentIndex]]; 
}

#pragma mark -
#pragma mark <TTImageViewDelegate>

- (void)imageView:(TTImageView*)imageView didLoadImage:(UIImage*)image
{
    [self unscheduleAutoscrolling];

    NSMutableArray *loadedImageViews = [self loadedImageViews];
    UIPageControl *pageControl = [self pageControl];

    // Add the TTImageView to loadedImageViews
    [loadedImageViews addObject:imageView];
    // Configuring pageControl
    [pageControl setNumberOfPages:[loadedImageViews count]];
    [self createCircularIllusion];
    [self scheduleAutoscrolling];
}

#pragma mark -
#pragma mark <LinkableScrollViewDelegate>

- (void)scrollViewDidTapped:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self isAnimating])
        return;
    for (CircularScrollEntry *entry in [self shownEntries]) {
        TTImageView *imageView = [entry imageView];
        UIView *touchedView = [imageView hitTest:
                [touch locationInView:imageView] withEvent:event];

        if (touchedView != nil) {
            // FIXME Should be done using a NSDictionary containing both the
            // TTImageView and the TableImageSutbtitleItem that represent
            // tapped banner
            ImageCarouselItem *carouselItem = [self object];

            for (TableImageSubtitleItem *item in [carouselItem imageItems])
                if ([item isKindOfClass:[TableImageSubtitleItem class]] &&
                        [[item imageURL] isEqualToString:
                            [imageView urlPath]]) {
                    [[TTNavigator navigator] openURLAction:
                            [[TTURLAction actionWithURLPath:[item URL]]
                                applyAnimated:YES]];
                }
            break;
        }
    }
}
@end
