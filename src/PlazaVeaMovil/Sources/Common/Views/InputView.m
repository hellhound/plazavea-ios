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

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    if ([self customSubview] == nil)
        [self initializeTextField];
    [super layoutSubviews];
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

@synthesize placeholder = _placeholder;

- (void)initializeTextField
{
    UITextField *textField = [[[UITextField alloc]
            initWithFrame:CGRectMake(0., 0.,
                    [self bounds].size.width - kHorizontalPadding * 2,
                    kTextFieldHeight)] autorelease];

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

#pragma mark -
#pragma mark  <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([@"" isEqualToString:[[textField text]
            stringByTrimmingCharactersInSet:kWhitespaceCharSet]])
        return NO;
    // The user pressed "Done" button, so dismiss the keyboard and return
    [textField resignFirstResponder];
    return YES;
}
@end
