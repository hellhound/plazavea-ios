#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BZActionSheetDelegate;

@interface BZActionSheet : UIView
{
    id<BZActionSheetDelegate> _delegate;
    UIImage *_backgroundImage;
    UILabel *_titleLabel;
    NSMutableArray *_buttons;
    NSInteger _cancelButtonIndex;
    NSInteger _firstOtherButtonIndex;
    CGFloat _maxHeight;
}
@property (nonatomic, assign) id<BZActionSheetDelegate> delegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSInteger cancelButtonIndex;
@property (nonatomic, readonly) NSInteger firstOtherButtonIndex;
@property (nonatomic, readonly) NSInteger numberOfButtons;
@property (nonatomic, readonly, getter = isVisible) BOOL visible;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, retain) UIImage *backgroundImage;

- (id)initWithTitle:(NSString *)title
           delegate:(id<BZActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtons:(NSArray *)otherButtons;
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (NSInteger)addButtonWithImage:(UIImage *)image;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated;
- (void)show;
@end

@protocol BZActionSheetDelegate <NSObject>

@optional

- (void)    actionSheet:(BZActionSheet *)actionSheet
   clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)        actionSheet:(BZActionSheet *)actionSheet
  didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)        actionSheet:(BZActionSheet *)actionSheet
 willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheetCancel:(BZActionSheet *)actionSheet;
- (void)didPresentActionSheet:(BZActionSheet *)actionSheet;
- (void)willPresentActionSheet:(BZActionSheet *)actionSheet;
@end