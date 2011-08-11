#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Application/AppDelegate.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/ShoppingListHeaderView.h"

static CGFloat const kStandardWidth = 320.;
static CGFloat const kStandardHeight = 480.;
static CGFloat kWidth;
static CGFloat kHeight;

@interface ShoppingListHeaderView (Private)

@property (nonatomic, retain) ShoppingList *shoppingList;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@end

@implementation ShoppingListHeaderView

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [ShoppingListHeaderView class]) {
        CGRect bounds = [[UIScreen mainScreen] bounds];

        kWidth = bounds.size.width / kStandardWidth;
        kHeight = bounds.size.height / kStandardWidth;
    }
}

- (void)dealloc
{
    [_shoppingList release];
    [_titleLabel release];
    [_dateLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (id)initWithShoppingList:(ShoppingList *)shoppingList
{
    if ((self = [super initWithFrame:
            CGRectMake(.0, .0, kWidth, kHeight)]) != nil) {
        [self setTitleLabel:
                [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
        [_titleLabel setText:[shoppingList name]];
        [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth |
                UIViewAutoresizingFlexibleRightMargin];
        [_titleLabel setNumberOfLines:0]; // unlimited number of lines
        [_titleLabel sizeToFit];
        [self setDateLabel:
                [[[UILabel alloc] initWithFrame:CGRectZero] autorelease]];
        [_dateLabel setText:[shoppingList formattedLastModiciationDate]];
        [_dateLabel setTextAlignment:UITextAlignmentRight];
        [_dateLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [_dateLabel sizeToFit];

        CGRect titleFrame = [_titleLabel frame];
        CGRect dateFrame = [_dateLabel frame];

        [_titleLabel setFrame:CGRectOffset(titleFrame, .0, .0)];
        [_dateLabel setFrame:CGRectOffset(dateFrame,
                kWidth - dateFrame.size.width, .0)];
        [self addSubview:_titleLabel];
        [self addSubview:_dateLabel];
    }
    return self;
}
@end
