#import "Common/Views/CustomizableAlertView.h"

@class UITextField;
@protocol UITextFieldDelegate;

@interface InputView: CustomizableAlertView <UITextFieldDelegate>
{
    NSString *_placeholder;
}
@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, copy) NSString *placeholder;
@end
