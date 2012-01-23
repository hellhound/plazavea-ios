#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Common/Views/PageCurlButton.h"

static NSString *const kCurlUpAndDownAnimationID = @"kCurlUpAndDownAnimationID";
static CGFloat const kCurlAnimationDuration = 0.8;
static CGFloat const kCurlAnimationShouldStopAfter = 0.44;

@interface PageCurlButton()

@property (nonatomic, assign, readwrite) BOOL isTargetViewCurled;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, retain) NSTimer *animationTimer;
@property (nonatomic, retain) NSTimer *timer;
@end

@implementation PageCurlButton

@synthesize targetView = targetView_;
@synthesize isTargetViewCurled = isTargetViewCurled_;
@synthesize isAnimating = isAnimating_;
@synthesize hidesWhenAnimating = hidesWhenAnimating_;
@synthesize hidesTargetViewWhileCurled = hidesTargetViewWhileCurled_;
@synthesize delegate = delegate_;
@synthesize animationTimer = animationTimer_;
@synthesize curlAnimationDuration = curlAnimationDuration_;
@synthesize curlAnimationShouldStopAfter = curlAnimationShouldStopAfter_;
@synthesize timer = timer_;

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
	CAAnimation *animation = [self.targetView.layer
            animationForKey:kCurlUpAndDownAnimationID];
    
	[animation setDelegate:nil];
	[self setTargetView:nil];
	[self.animationTimer invalidate];
	[self setAnimationTimer:nil];
	[self.timer invalidate];
	[self setTimer:nil];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    if (self) {		
        self.curlAnimationDuration = kCurlAnimationDuration;
		self.curlAnimationShouldStopAfter = kCurlAnimationShouldStopAfter;
		self.hidesWhenAnimating = NO;
		self.hidesTargetViewWhileCurled = YES;
        /*UIImage *buttonImage = [UIImage imageNamed:@"pageCurl.png"];
        
        [self setImage: buttonImage forState:UIControlStateNormal];
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y,
                buttonImage.size.width, buttonImage.size.height)];*/
		[self addTarget:self action:@selector(touched)
                forControlEvents:UIControlEventTouchUpInside];
        
		/*self.backgroundColor = [UIColor colorWithRed:0.9 green:0.5
                blue:0.5 alpha:0.8];*/
        
		[[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(curlViewDown)
                    name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)setIsAnimating:(BOOL)yesOrNo
{
	isAnimating_ = yesOrNo;
    
	if (yesOrNo) {
		if (self.hidesWhenAnimating) {
			[self setHidden:YES];
		}
	} else {
		if (self.hidesWhenAnimating) {
			[self setHidden:NO];
		}
	}
}

- (void)touched
{
	if (!self.isTargetViewCurled) {
		[self curlViewUp];
	} else {
		[self curlViewDown];
	}
    
}

- (void)curlViewUp
{
	if (!self.isAnimating && !self.isTargetViewCurled) {
		self.isAnimating = YES;
        
		[UIView beginAnimations:kCurlUpAndDownAnimationID context:nil];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
                forView:self.targetView cache:YES];
		[UIView setAnimationDuration:self.curlAnimationDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationRepeatAutoreverses:YES];
		[UIView commitAnimations];
	}
}

- (void)curlViewDown
{
	if (!self.isAnimating && self.isTargetViewCurled) {
		self.isAnimating = YES;
        
		if ([self.delegate respondsToSelector:
                @selector(pageCurlButtonWillCurlViewDown:)]) {
			[self.delegate pageCurlButtonWillCurlViewDown:self];
		}
		CFTimeInterval pausedTime = [self.targetView.layer timeOffset];
		self.targetView.layer.speed = 1.0;
		self.targetView.layer.timeOffset = 0.0;
		self.targetView.layer.beginTime = 0.0;
		CFTimeInterval timeSincePause = [self.targetView.layer
                convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
		self.targetView.layer.beginTime = timeSincePause - 2 *
                (self.curlAnimationDuration-self.curlAnimationShouldStopAfter);
        
		if (self.hidesTargetViewWhileCurled) {
			// Necessary to avoid a flick during the removal of layer and
            // setting the target view visible again
			self.timer = [NSTimer scheduledTimerWithTimeInterval:
                    (self.curlAnimationDuration -
                        self.curlAnimationShouldStopAfter - 0.05) target:self
                        selector:@selector(setTargetViewVisible) userInfo:nil
                        repeats:NO];
		}
	}
}

- (void)setTargetViewVisible
{
	[self.timer invalidate];
	[self setTimer:nil];    
	[self.targetView setHidden:NO];
}

- (void)cancelCurlingAnimation
{
	[self.targetView.layer removeAllAnimations];
    
	self.targetView.layer.speed = 1.0;
	self.targetView.layer.timeOffset = 0.0;
	self.targetView.layer.beginTime = 0.0;
	self.isTargetViewCurled = NO;
	self.isAnimating = NO;
}

- (void)animationWillStart:(NSString *)animationID context:(void *)context
{
	if ([self.delegate respondsToSelector:
            @selector(pageCurlButtonWillCurlViewUp:)]) {
		[self.delegate pageCurlButtonWillCurlViewUp:self];
	}
	self.isAnimating = YES;
	if (self.hidesTargetViewWhileCurled) {
		[self.targetView setHidden:YES];
	}
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:
            self.curlAnimationShouldStopAfter target:self
                selector:@selector(stopCurl) userInfo:nil repeats:NO];
	return;
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context
{
	if (self.hidesTargetViewWhileCurled) {
		[self.targetView setHidden:NO];
	}
	self.isTargetViewCurled = NO;
	self.isAnimating = NO;
    
	if ([self.delegate respondsToSelector:
            @selector(pageCurlButtonDidCurlViewDown:)]) {
		[self.delegate pageCurlButtonDidCurlViewDown:self];
	}
}

- (void)stopCurl {
	[self.animationTimer invalidate];
	[self setAnimationTimer:nil];
    
	CFTimeInterval pausedTime = [self.targetView.layer
            convertTime:CACurrentMediaTime() fromLayer:nil];
    self.targetView.layer.speed = 0.0;
    self.targetView.layer.timeOffset = pausedTime;
	self.isTargetViewCurled = YES;
	self.isAnimating = NO;
    
	if ([self.delegate 
            respondsToSelector:@selector(pageCurlButtonDidCurlViewUp:)]) {
		[self.delegate pageCurlButtonDidCurlViewUp:self];
	}
}
@end