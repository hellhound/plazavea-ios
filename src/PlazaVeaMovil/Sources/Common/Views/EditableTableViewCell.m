#import <math.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Views/EditableTableViewCell.h"

static NSString *kDefaultPlaceholder = @"Enter text here";
// NSLocalizedString(@"Enter text here", nil)
static NSString *kPlaceholder;
static CGFloat kHorizontalMargin = 10.;
static CGFloat kVerticalMargin = 2.;
static NSString *kTextKeyPath = @"text";

@interface EditableTableViewCell (Private)

- (void)initializeTextField;
- (CGRect)textFieldFrame;
- (void)copyProperties;
@end

@implementation EditableTableViewCell

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [EditableTableViewCell class])
        kPlaceholder = NSLocalizedString(kDefaultPlaceholder, nil);
}

- (void)dealloc
{
    [_textField removeObserver:self forKeyPath:kTextKeyPath];
    [_textField setDelegate:nil];
    [_textField release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueObserving)

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    // Make sure we are observing kTextKeyPath from _textField
    if (_textField == object && [keyPath isEqualToString:kTextKeyPath] &&
            [[change objectForKey:NSKeyValueChangeKindKey] integerValue] ==
            NSKeyValueChangeSetting)
        // We can't be _textField's delegate, that's why we should observe its
        // value with KVO
        [[self textLabel] setText:
                [change objectForKey:NSKeyValueChangeNewKey]];
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self copyProperties];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];

    if ([self isEditing]) {
        UIView *contentView = [self contentView];

        if (view != nil && ![_textField isFirstResponder] &&
                (contentView == view || ![[self subviews] containsObject:view]))
            return _textField;
    }
    return view;
}

#pragma mark -
#pragma mark UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style
            reuseIdentifier:reuseIdentifier]) != nil) {
        [self initializeTextField];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    UILabel *textLabel = [self textLabel];

    if (editing) {
        [_textField setHidden:NO];
        [textLabel setHidden:YES];
        [self bringSubviewToFront:_textField];
        [self sendSubviewToBack:textLabel];
    } else {
        [_textField setHidden:YES];
        [textLabel setHidden:NO];
        [self sendSubviewToBack:_textField];
        [self bringSubviewToFront:textLabel];
    }
    [super setEditing:editing animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:NO];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark -
#pragma mark EditableTableViewCell (Private)

- (void)initializeTextField
{
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [_textField setBorderStyle:UITextBorderStyleNone];
    [_textField setPlaceholder:kPlaceholder];
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_textField setAutoresizingMask:
            UIViewAutoresizingFlexibleWidth |
            UIViewAutoresizingFlexibleHeight];
    [_textField setHidden:YES];
    // We can't be _textField's delegate
    [_textField addObserver:self forKeyPath:kTextKeyPath
            options:NSKeyValueObservingOptionNew context:NULL];
    [[self contentView] addSubview:_textField];
}

- (CGRect)textFieldFrame
{
    CGRect frame = CGRectZero;
    CGRect bounds = [[self contentView] bounds];
    UIView *textLabel = [self textLabel];
    UIView *detailTextLabel = [self detailTextLabel];
    UIView *accessoryView = [self accessoryView];
    UIView *editingAccessoryView = [self editingAccessoryView];

    // Set the origin
    if (textLabel == nil) {
        // Could this be possible? wtf?
        frame.origin = CGPointMake(kHorizontalMargin, kVerticalMargin);
    } else {
        CGRect labelFrame = [textLabel frame];
        frame.origin.x = kHorizontalMargin > labelFrame.origin.x ?
                kHorizontalMargin : labelFrame.origin.x;
        frame.origin.y = kVerticalMargin > labelFrame.origin.y ?
                kHorizontalMargin : labelFrame.origin.y;
    }
    // Set the size
    // We can manage to get the correct size by poking the origin of
    // detailTextLabel (for the lower bound) and accessoryView, 
    // editingAccessoryView or contentView's bounds, in that order, for the
    // right bound.
    frame.size.height = (detailTextLabel == nil ? bounds.size.height :
            fabsf([detailTextLabel frame].origin.y - frame.origin.y)) -
            kVerticalMargin + 1;
    frame.size.width = (accessoryView == nil ?
            (editingAccessoryView == nil ?
            bounds.size.width :
            fabsf([editingAccessoryView frame].origin.x - frame.origin.x)) :
            fabsf([accessoryView frame].origin.x - frame.origin.x)) -
            kHorizontalMargin + 1;
    return frame;
}

- (void)copyProperties
{
    UILabel *textLabel = [self textLabel];

    [_textField setFont:[textLabel font]];
    [_textField setText:[textLabel text]];
    [_textField setTextAlignment:[textLabel textAlignment]];
    [_textField setTextColor:[textLabel textColor]];
    [_textField setBackgroundColor:[textLabel backgroundColor]];
    [_textField setFrame:[self textFieldFrame]];
}

#pragma mark -
#pragma mark EditableTableViewCell (Public)

@synthesize textField = _textField;
@end
