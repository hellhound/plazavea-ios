#import <math.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Views/EditableTableViewCell.h"

static NSString *kDefaultPlaceholder = @"Enter text here";
// NSLocalizedString(@"Enter text here", nil)
static NSString *kPlaceholder;
static CGFloat kHorizontalMargin = 10.;
static CGFloat kVerticalMargin = 2.;

@interface EditableTableViewCell (Private)

- (void)initializeTextField;
- (CGRect)textFieldFrame;
@end

@implementation EditableTableViewCell

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [EditableTableViewCell class])
        kPlaceholder = NSLocalizedString(kDefaultPlaceholder, nil);
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style
            reuseIdentifier:reuseIdentifier]) != nil)
        [self initializeTextField];
    return self;
}

- (void)dealloc
{
    [_textField setDelegate:nil];
    [_textField release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewCell

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    UILabel *textLabel = [self textLabel];

    if (editing) {
        [_textField setHidden:NO];
        [textLabel setHidden:YES];
        [self bringSubviewToFront:_textField];
        [self sendSubviewToBack:textLabel];
        [_textField setText:[textLabel text]];
        [_textField setFont:[textLabel font]];
        [_textField setFrame:[self textFieldFrame]];
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
    //CGRect bounds = [[self contentView] bounds];

    //_textField = [[UITextField alloc] initWithFrame:
    //        CGRectInset(bounds, 10., 2.)];
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [_textField setBorderStyle:UITextBorderStyleNone];
    [_textField setPlaceholder:kPlaceholder];
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_textField setAutoresizingMask:
            UIViewAutoresizingFlexibleWidth |
            UIViewAutoresizingFlexibleHeight];
    [_textField setHidden:YES];
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
            kVerticalMargin;
    frame.size.width = (accessoryView == nil ?
            (editingAccessoryView == nil ?
            bounds.size.width :
            fabsf([editingAccessoryView frame].origin.x - frame.origin.x)) :
            fabsf([accessoryView frame].origin.x - frame.origin.x)) -
            kHorizontalMargin;
    return frame;
}

#pragma mark -
#pragma mark EditableTableViewCell (Public)

@synthesize textField = _textField;
@end
