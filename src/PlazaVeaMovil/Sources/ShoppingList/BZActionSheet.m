#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/BZActionSheet.h"

const CGFloat kASWidth = 320.;
const CGFloat kASLeftMargin = 30.;
const CGFloat kASTopMargin = 8.;
const CGFloat kASBottomMargin = 15.;
const CGFloat kASRowMargin = 15.;
const CGFloat kASColumnMargin = 20.;
const int kASButtonsPerRow = 3;
const CGFloat kASTitleFontSize = 14.;
const CGFloat kASButtonFonSize = 18.;
const CGFloat kASAnimationDuration = .2;
NSString *const kASBackgroundImageName = @"background.png";
NSString *const kASButtonBackground =@"buttonBackground.png";
NSString *const kASButtonBackgroundHighlighted =
        @"buttonBackground_Highlighted";
NSString *const kASCancelButtonBackground = @"cancelButtonBackground.png";

#pragma mark -
#pragma mark BZOverlayWindow

@interface BZOverlayWindow: UIWindow
{
    UIWindow *_oldKeyWindow;
    UIViewController *_rootController;
}
@property (nonatomic, retain) UIWindow *oldKeyWindow;
@property (nonatomic, retain) UIViewController *rootController;
@end

@implementation  BZOverlayWindow

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_oldKeyWindow release];
    _rootController = nil;
    [super dealloc];
}

#pragma mark -
#pragma UIWindow

- (void)makeKeyAndVisible
{
    UIView *background =
            [[[UIView alloc] initWithFrame:[self frame]] autorelease];
    
    [background setBackgroundColor:[UIColor colorWithWhite:.0 alpha:.5]];
    [self insertSubview:background atIndex:0];
    [self setOldKeyWindow:[[UIApplication sharedApplication] keyWindow]];
    [self setWindowLevel:UIWindowLevelAlert];
    [super makeKeyAndVisible];
}

- (void)resignKeyWindow
{
    [super resignKeyWindow];
    [_oldKeyWindow makeKeyAndVisible];
}

#pragma mark -
#pragma mark BZOverlayWindow

@synthesize oldKeyWindow = _oldKeyWindow, rootController = _rootController;

- (void)setRootController:(UIViewController *)rootController
{
    if (_rootController != rootController) {
        [[_rootController view] removeFromSuperview];
        [_rootController autorelease];
        
        _rootController = [rootController retain];
        
        [self addSubview:[rootController view]];
    }
}
@end

#pragma mark -
#pragma mark BZActionSheetController

@interface BZActionSheetController: UIViewController
@end

@implementation BZActionSheetController

// for handling screen rotation TODO
@end

#pragma mark -
#pragma mark BZActionSheet

@interface BZActionSheet (private)

@property (nonatomic, readonly) NSMutableArray *buttons;
@property (nonatomic, readonly) UILabel *titleLabel;
- (void)setDefaults;
- (void)releaseWindow:(int)buttonIndex;
- (void)slideIn;
- (CGSize)titleLabelSize;
- (CGSize)buttonsAreaSize;
- (CGSize)sizeAndLayout:(BOOL)layout;
- (void)onButtonPress:(id)sender;
@end

@implementation BZActionSheet

@synthesize delegate = _delegate, backgroundImage = _backgroundImage,
        cancelButtonIndex = _cancelButtonIndex, maxHeight = _maxHeight,
            firstOtherButtonIndex = _firstOtherButtonIndex;

#pragma mark 
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setDefaults];
    return self;
}

- (void)dealloc
{
    _delegate = nil;
    [_backgroundImage release];
    [_buttons release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) != nil) {
        [self setDefaults];
        if (!CGRectIsEmpty(frame)) {
            _maxHeight = frame.size.height;
        }
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)noSize
{
    CGSize size = [self sizeAndLayout:NO];
    
    return size;
}

- (void)layoutSubviews
{
    [self sizeAndLayout:YES];
}

- (void)drawRect:(CGRect)rect
{
    UIImageView *backgroundView = [[[UIImageView alloc]
            initWithImage:[self backgroundImage]] autorelease];
    
    [self addSubview:backgroundView];
}

#pragma mark -
#pragma mark BZActionSheet (Public)

- (id)initWithTitle:(NSString *)title
           delegate:(id<BZActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtons:(NSArray *)otherButtons
{
    if ((self = [super init]) != nil) {
        _delegate = delegate;
        
        [self setTitle:title];
        for (id button in otherButtons) {
            if ([button isKindOfClass:[UIImage class]]) {
                _firstOtherButtonIndex = 0;
                [self addButtonWithImage:button];
            }
        }
        if (cancelButtonTitle != nil) {
            [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:[_buttons count] - 1];
        }
    }
    return self;
}

- (UIImage *)backgroundImage
{
    if (_backgroundImage == nil)
        [self setBackgroundImage:[UIImage imageNamed:kASBackgroundImageName]];
    return _backgroundImage;
}

- (void)setTitle:(NSString *)title
{
    [[self titleLabel] setText:title];
}

- (NSString *)title
{
    return [_titleLabel text];
}

- (NSInteger)numberOfButtons
{
    return [_buttons count];
}

- (void)setCancelButtonIndex:(NSInteger)cancelButtonIndex
{
    if (cancelButtonIndex < 0 || cancelButtonIndex >= [_buttons count])
        return;
    _cancelButtonIndex = cancelButtonIndex;
    UIButton *button = [_buttons objectAtIndex:cancelButtonIndex];
    UIImage *backgroundNormal =
            [UIImage imageNamed:kASCancelButtonBackground];
    backgroundNormal = [backgroundNormal
            stretchableImageWithLeftCapWidth:[backgroundNormal size].width / 2.
                topCapHeight:[backgroundNormal size].height / 2.];
    
    [button setBackgroundImage:backgroundNormal forState:UIControlStateNormal];
    
    UIImage *backgroundPressed = [UIImage
            imageNamed:kASButtonBackgroundHighlighted];
    backgroundPressed = [backgroundPressed
            stretchableImageWithLeftCapWidth:[backgroundPressed size].width / 2.
                topCapHeight:[backgroundPressed size].height / 2.];
    
    [button setBackgroundImage:backgroundPressed
            forState:UIControlStateHighlighted];
    [[button titleLabel] setFont:
            [UIFont boldSystemFontOfSize:kASButtonFonSize]];
    [[button titleLabel] setShadowOffset:CGSizeMake(.0, 1.)];
    [button setTitleShadowColor:[UIColor colorWithWhite:1. alpha:.6]
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setReversesTitleShadowWhenHighlighted:YES];
}

- (BOOL)isVisible
{
    return ([self superview] != nil);
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    UIImage *backgroundNormal =
            [UIImage imageNamed: kASButtonBackground];
    backgroundNormal = [backgroundNormal
            stretchableImageWithLeftCapWidth:[backgroundNormal size].width / 2.
                topCapHeight:[backgroundNormal size].height / 2.];
    
    [button setBackgroundImage:backgroundNormal forState:UIControlStateNormal];
    
    UIImage *backgroundPressed =
            [UIImage imageNamed:kASButtonBackgroundHighlighted];
    backgroundPressed = [backgroundPressed
            stretchableImageWithLeftCapWidth:backgroundPressed.size.width / 2.
                topCapHeight:[backgroundPressed size].height / 2.];
    
    [button setBackgroundImage:backgroundPressed
            forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(onButtonPress:)
            forControlEvents:UIControlEventTouchUpInside];
    [[self buttons] addObject:button];
    [self setNeedsLayout];
    return [[self buttons] count] - 1;
}

- (NSInteger)addButtonWithImage:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    
    UIImage *backgroundNormal =
            [UIImage imageNamed:kASButtonBackground];
    backgroundNormal = [backgroundNormal
            stretchableImageWithLeftCapWidth:[backgroundNormal size].width / 2.
                topCapHeight:[backgroundNormal size].height / 2.];
    
    [button setBackgroundImage:backgroundNormal forState:UIControlStateNormal];
    
    UIImage *backgroundPressed =
            [UIImage imageNamed:kASButtonBackgroundHighlighted];
    backgroundPressed = [backgroundPressed
            stretchableImageWithLeftCapWidth:backgroundPressed.size.width / 2.
                topCapHeight:[backgroundPressed size].height / 2.];
    
    [button setBackgroundImage:backgroundPressed
            forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(onButtonPress:)
            forControlEvents:UIControlEventTouchUpInside];
    [[self buttons] addObject:button];
    [self setNeedsLayout];
    return [[self buttons] count] - 1;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated
{
    if ([_delegate respondsToSelector:
            @selector(actionSheet:willDismissWithButtonIndex:)])
        [_delegate actionSheet:self willDismissWithButtonIndex:buttonIndex];
    if (animated) {
        CGRect frame = [self frame];
        frame.origin.y = [self bounds].size.height;
        
        [[self window] setBackgroundColor:[UIColor clearColor]];
        [[self window] setAlpha:1.];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kASAnimationDuration];
        [[self window] resignKeyWindow];
        [[self window] setAlpha:.0];
        [self setFrame:frame];
        [self releaseWindow:buttonIndex];
        [UIView commitAnimations];
    } else {
        [[self window] resignKeyWindow];
        [self releaseWindow:buttonIndex];
    }
}

- (void)show
{
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
            beforeDate:[NSDate date]];
    
    UIViewController *viewController =
            [[[UIViewController alloc] init] autorelease];
    
    [[viewController view] setBackgroundColor:[UIColor clearColor]];
    
    BZOverlayWindow *overlayWindow = [[BZOverlayWindow alloc]
            initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [overlayWindow setRootController:viewController];
    [overlayWindow makeKeyAndVisible];
    if ([_delegate respondsToSelector:@selector(willPresentActionSheet:)])
        [_delegate willPresentActionSheet:self];
    [[viewController view] addSubview:self];
    [self sizeToFit];

    CGRect frame = [self frame];    
    frame.origin.y = [[self superview] bounds].size.height;
    
    [self setFrame:frame];
    [self slideIn];
}

#pragma mark -
#pragma mark BZActionSheet (Private)

- (NSMutableArray *)buttons
{
    if (_buttons == nil)
        _buttons = [[NSMutableArray arrayWithCapacity:6] retain];
    return _buttons;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        
        [_titleLabel setFont:[UIFont systemFontOfSize:kASTitleFontSize]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setShadowColor:[UIColor colorWithWhite:.0 alpha:.6]];
        [_titleLabel setShadowOffset:CGSizeMake(.0, -0.5)];
        [_titleLabel setTextAlignment:UITextAlignmentCenter];
        [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}

- (void)setDefaults
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin |
                UIViewAutoresizingFlexibleTopMargin |
                UIViewAutoresizingFlexibleBottomMargin];
    [self setMaxHeight:.0];
    _cancelButtonIndex = -1;
    _firstOtherButtonIndex = -1;
}

- (void)releaseWindow:(int)buttonIndex
{
    if ([_delegate respondsToSelector:
            @selector(actionSheet:didDismissWithButtonIndex:)])
        [_delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
    [[self window] release];
}

- (void)slideIn
{
    CGFloat y = [[self superview] bounds].size.height - _maxHeight;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kASAnimationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self setFrame:CGRectMake(0, y, kASWidth, _maxHeight)];
    [UIView commitAnimations];
    if ([_delegate respondsToSelector:@selector(didPresentActionSheet:)])
        [_delegate didPresentActionSheet:self];
}

- (CGSize)titleLabelSize
{
    CGFloat maxWidth = kASWidth - (kASLeftMargin * 2);
    CGSize size = [[[self titleLabel] text] sizeWithFont:[_titleLabel font]
            constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)
                lineBreakMode:UILineBreakModeWordWrap];
    if (size.width < maxWidth)
        size.width = maxWidth;
    return size;
}

- (CGSize)buttonsAreaSize
{
    CGFloat maxWidth = kASWidth - (kASLeftMargin * 2.);
    int totalButtons = [_buttons count] - 1;
    int rowCount = totalButtons / kASButtonsPerRow;
    
    if ((totalButtons % kASButtonsPerRow) > 0) {
        rowCount++;
    }
    CGSize size = [[_buttons objectAtIndex:0] sizeThatFits:CGSizeZero];
    size.width = maxWidth;
    size.height = (size.height * (rowCount + 1)) + (kASRowMargin * rowCount);

    return size;
}

- (CGSize)sizeAndLayout:(BOOL)layout
{
    CGFloat maxWidth = kASWidth - (kASLeftMargin * 2.);
    CGSize titleLabelSize = [self titleLabelSize];
    CGSize buttonsAreaSize = [self buttonsAreaSize];
    CGFloat totalHeight = kASTopMargin + titleLabelSize.height + kASTopMargin +
            buttonsAreaSize.height + kASBottomMargin;
    _maxHeight = totalHeight;
    
    if (totalHeight > _maxHeight) {
        // TODO: too much stuff to fit in screen
    }
    if (layout) {
        // title
        CGFloat y = kASTopMargin;
        
        if ([self title] != nil) {
            [_titleLabel setFrame:CGRectMake(kASLeftMargin, y,
                    titleLabelSize.width, titleLabelSize.height)];
            [self addSubview:_titleLabel];
            y += titleLabelSize.height;
        }
        y += kASTopMargin;
        // buttons
        int totalButtons = [_buttons count] - 1;
        int rowCount = totalButtons / kASButtonsPerRow;
        
        if ((totalButtons % kASButtonsPerRow) > 0) {
            rowCount++;
        }
        CGFloat buttonHeight =
                [[_buttons objectAtIndex:0] sizeThatFits:CGSizeZero].height;
        CGFloat buttonWidth = (maxWidth -
                (kASColumnMargin * (kASButtonsPerRow - 1.))) /
                    kASButtonsPerRow;
       
        for (int row = 0; row < rowCount; row++) {
            CGFloat x = kASLeftMargin;
            
            for (int column = 0; column < kASButtonsPerRow; column++) {
                int buttonPos = ((row * kASButtonsPerRow) + column);
                if (buttonPos < totalButtons) {
                    // TODO: align buttons in the last row
                    UIButton *button = [_buttons objectAtIndex:buttonPos];
                    
                    [button setFrame:
                            CGRectMake(x, y, buttonWidth, buttonHeight)];
                    [self addSubview:button];
                    x += buttonWidth + kASColumnMargin;
                }
            }
            y += buttonHeight + kASRowMargin;
        }
        // Cancel button
        UIButton *cancelButton = [_buttons objectAtIndex:_cancelButtonIndex];

        [cancelButton setFrame:
                CGRectMake(kASLeftMargin, y, maxWidth, buttonHeight)];
        [self addSubview:cancelButton];
    }
    return CGSizeMake(kASWidth, totalHeight);
}

- (void)onButtonPress:(id)sender
{
    int buttonIndex = [_buttons indexOfObjectIdenticalTo:sender];
    
    if ([_delegate respondsToSelector:
            @selector(actionSheet:clickedButtonAtIndex:)])
        [_delegate actionSheet:self clickedButtonAtIndex:buttonIndex];
    if (buttonIndex == _cancelButtonIndex &&
            [_delegate respondsToSelector:@selector(actionSheetCancel:)])
        [_delegate actionSheetCancel:self];
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}
@end