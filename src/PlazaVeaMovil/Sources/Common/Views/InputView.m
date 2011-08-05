#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Views/InputView.h"

static CGFloat kTextFieldHeight = 25.;
static CGFloat kHorizontalPadding = 12.;
static NSString *kDefaultPlaceholder = @"Enter text here";
// NSLocalizedString(@"Enter text here", nil)
static NSString *kPlaceholder;
static NSCharacterSet *kWhitespaceCharSet;

@interface InputView (Private)

- (void)initializeTextField;
- (BOOL)testValue:(NSString *)value;
@end

@implementation InputView

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [InputView class]) {
        kPlaceholder = NSLocalizedString(kDefaultPlaceholder, nil);
        kWhitespaceCharSet =
                [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
    }
}

- (void)dealloc
{
    [_placeholder release];
    [_initialText release];
    [_userInfo release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    if ([self customSubview] == nil)
        [self initializeTextField];
    [super layoutSubviews];
}

#pragma mark -
#pragma mark UIAlertView

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated
{
    UITextField *textField = [self textField];

    if ([self testValue:[textField text]] ||
            buttonIndex == [self cancelButtonIndex])
        // passed the test, dismiss
        [super dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

#pragma mark -
#pragma mark CustomizableAlertView

- (void)setCustomSubview:(UIView *)view
{
    // NO-OP, should be readonly our control
}

- (UITextField *)textField
{
    return (UITextField *)[self customSubview];
}

#pragma mark -
#pragma mark InputView

@synthesize placeholder = _placeholder, initialText = _initialText,
        userInfo = _userInfo;

- (NSMutableDictionary *)userInfo
{
    if (_userInfo == nil)
        _userInfo = [[NSMutableDictionary alloc] init];
    return _userInfo;
}

- (void)initializeTextField
{
    UITextField *textField = [[[UITextField alloc]
            initWithFrame:CGRectMake(0., 0.,
                    [self bounds].size.width - kHorizontalPadding * 2,
                    kTextFieldHeight)] autorelease];

    [textField setText:_initialText];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setPlaceholder:
            _placeholder == nil ? kPlaceholder : _placeholder];
    [textField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setAutoresizingMask:
            UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleTopMargin];
    [textField setDelegate:self];
    // call the setter from the superclass becaused we overrode it to do
    // nothing
    [super setCustomSubview:textField];
}

- (BOOL)testValue:(NSString *)value
{
    if([@"" isEqualToString:[value stringByTrimmingCharactersInSet:
            kWhitespaceCharSet]] || value == nil)
        return NO;
    return YES;
}

#pragma mark -
#pragma mark  <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self testValue:[textField text]])
        return NO;
    // The user pressed "Done" button, so dismiss the keyboard and return
    [textField resignFirstResponder];
    return YES;
}
@end
