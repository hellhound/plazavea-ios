#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PageCurlButtonDelegate;

@interface PageCurlButton: UIButton
{
@private
	UIView *targetView_;
	BOOL isTargetViewCurled_;
	BOOL isAnimating_;
	BOOL hidesWhenAnimating_; // Default to NO
	BOOL hidesTargetViewWhileCurled_; // Default to YES    
	id <PageCurlButtonDelegate> delegate_;
	NSTimer *animationTimer_;
	NSTimeInterval curlAnimationDuration_;
	NSTimeInterval curlAnimationShouldStopAfter_;
	NSTimer *timer_;
}
@property (nonatomic, retain) UIView *targetView;
@property (nonatomic, assign, readonly) BOOL isTargetViewCurled;
@property (nonatomic, assign) BOOL hidesWhenAnimating;
@property (nonatomic, assign) BOOL hidesTargetViewWhileCurled;
@property (nonatomic, assign) id <PageCurlButtonDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval curlAnimationDuration;
@property (nonatomic, assign) NSTimeInterval curlAnimationShouldStopAfter;
- (void)curlViewUp;
- (void)curlViewDown;
- (void)cancelCurlingAnimation;
@end

@protocol PageCurlButtonDelegate <NSObject>

@optional
- (void)pageCurlButtonWillCurlViewUp:(PageCurlButton *)control;
- (void)pageCurlButtonDidCurlViewUp:(PageCurlButton *)control;
- (void)pageCurlButtonWillCurlViewDown:(PageCurlButton *)control;
- (void)pageCurlButtonDidCurlViewDown:(PageCurlButton *)control;
@end