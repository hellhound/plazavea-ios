#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Common/Views/CustomizableAlertView.h"

static CGFloat kVerticalPadding = 10.;
static CGFloat kMinHorizontalPadding = 12.;
static NSString *kTransformKeyPath = @"transform";

@interface CustomizableAlertView (Private)

- (void)centerView:(id)sender;
@end

@implementation CustomizableAlertView

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_customSubview release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueObserving)

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    // Make sure we are observing kTransformKeyPath from self
    if (_customSubview != nil && self == object &&
            [keyPath isEqualToString:kTransformKeyPath]) {
        // We should remove the observing object to avoid a recursion
        [self removeObserver:self forKeyPath:kTransformKeyPath];

        CGFloat displacement =
                [_customSubview frame].size.height / 2. + kVerticalPadding;

        [self setTransform:
                CGAffineTransformMakeTranslation(.0, -displacement)];
        // Resume the observation
        [self addObserver:self forKeyPath:kTransformKeyPath options:0
                context:NULL];
    }
}

#pragma mark -
#pragma mark UIResponder

- (BOOL)becomeFirstResponder
{
    // For some unkown reason UIAlertView can be first responder. Disabling
    // this completely fixes this bug http://stackoverflow.com/q/6866932/434423
    // BTW, overriding "canBecomeFirstResponder" to return "NO" doesn't work,
    // this is why we override this instead of "canBecomeFirstResponder".
    return NO;
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSArray *subviews = [self subviews];
    CGRect customFrame = [_customSubview frame];
    CGFloat displacement = customFrame.size.height  + kVerticalPadding * 2.;

    if ([_customSubview superview] == nil) {
        // Calculate the background size and elnarge it accordingly
        UIView *backgroundView = nil;

        // Perform a pattern search instead of depending on UIAlertView internal
        // structure.
        // This fetches the background view.
        for (UIView *view in subviews) 
            if ([view isKindOfClass:[UIImageView class]]) {
                backgroundView = view;
                break;
            }
        if (backgroundView == nil)
            // Abort if there is no match
            return;

        CGRect backgroundFrame = [backgroundView frame];

        // increment background image-view height by "displacement"
        backgroundFrame.size.height += displacement;
        [backgroundView setFrame:backgroundFrame];
    } else {
        // The custom subview is already inside the hierarchy
        [_customSubview removeFromSuperview];
    }

    UIView *messageView = nil;

    // Perform a pattern search instead of depending on UIAlertView internal
    // structure
    // This fetches the view that we'll use as an anchor.
    for (UIView *view in subviews)
        if ([view isKindOfClass:[UILabel class]] &&
                [[(UILabel *)view text] isEqualToString:[self message]]) {
            messageView = view;
            break;
        }
    if (messageView == nil)
        // Abort if there is no match
        return;

    CGRect bounds = [self bounds];
    CGRect messageFrame = [messageView frame];
    CGFloat pivot = messageFrame.origin.y + messageFrame.size.height;

    // displace by "diplacement" every subview positioned after "pivot"
    for (UIView *view in subviews) {
        CGRect viewRect = [view frame];

        if (viewRect.origin.y > pivot)
            [view setFrame:CGRectOffset(viewRect, .0, displacement)];
    }

    CGFloat maxWidth = bounds.size.width - kMinHorizontalPadding * 2.;

    if (customFrame.size.width > maxWidth)
        customFrame.size.width = maxWidth;
    [_customSubview setFrame:CGRectMake(
            (bounds.size.width - customFrame.size.width) / 2.,
            pivot + kVerticalPadding,
            customFrame.size.width, customFrame.size.height)];
    [self addSubview:_customSubview];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // perform hit-test for every subview
    for (UIView *view in [self subviews])
        if ([view pointInside:[self convertPoint:point toView:view]
                withEvent:event])
            return YES;
    return NO;
}

#pragma mark -
#pragma mark UIAlertView

- (void)show
{
    // TODO has a major bug when displaying for second time. Apparently this
    // view translates upwards form some reason. 
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

    [defaultCenter addObserver:self selector:@selector(centerView:)
        name:UITextFieldTextDidEndEditingNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(centerView:)
            name:UITextViewTextDidEndEditingNotification object:nil];
    // Dammit! we need to observe value-changes for the property "transform" to
    // handle properly the UIAlertView relocation.
    // We need to hang this onto "show" because UIAlertView's designated
    // initializer is imposible to override due to its variadic parameter (...).
    [self addObserver:self forKeyPath:kTransformKeyPath options:0 context:NULL];
    [super show];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Cease to observe kTransformKeyPath upon dismissal
    [self removeObserver:self forKeyPath:kTransformKeyPath];
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

#pragma mark -
#pragma mark CustomizableAlertView

@synthesize customSubview = _customSubview;

- (void)centerView:(id)sender
{
    CGRect bounds = [[self superview] bounds];

    [self setCenter:CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))];
}
@end
