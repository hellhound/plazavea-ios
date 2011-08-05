#import "Common/Views/CustomizableAlertView.h"

@class UITextField;
@class NSString;
@class NSDictionary;
@protocol UITextFieldDelegate;

@interface InputView: CustomizableAlertView <UITextFieldDelegate>
{
    NSString *_initialText;
    NSMutableDictionary *_userInfo;
}
@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, copy) NSString *initialText;
@property (nonatomic, readonly) NSMutableDictionary *userInfo;
@end
