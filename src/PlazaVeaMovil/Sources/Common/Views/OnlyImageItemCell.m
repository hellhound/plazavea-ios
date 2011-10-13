#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "Common/Views/OnlyImageItemCell.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageSize = 50;

@implementation OnlyImageItemCell

#pragma mark -
#pragma mark OnlyImageItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object 
{
    TTTableImageItem *item = object;    
    UIImage *image = [item imageURL] != nil ? 
            [[TTURLCache sharedCache] imageForURL:[item imageURL]] : 
            [item defaultImage];
    TTImageStyle *style = [[item imageStyle] 
            firstStyleOfClass:[TTImageStyle class]];

    return style != nil ? [style size].height : 
            (image != nil ? [image size].height :
                ([item imageURL] != nil ? kDefaultImageSize : 0));
}

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)identifier
{
    if (self = [super initWithStyle:style reuseIdentifier:identifier])
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    return self;
}

- (void)layoutSubviews
{
    UIView *contentView = [self contentView];
    TTImageView *imageView2 = [self imageView2];
    CGSize imageSize = [[imageView2 image] size];
    UILabel *textLabel = [self textLabel];
    NSString *text = [textLabel text];

    [imageView2 setFrame:CGRectMake(.0, .0, imageSize.width, imageSize.height)];
    [contentView addSubview:imageView2];
    [contentView sizeToFit];

    if (text == nil) {
        [[self textLabel] setFrame:CGRectZero];
    } else {
        CGFloat maxWidth = CGRectGetWidth([imageView2 frame]) -
                kTableCellHPadding * 2;
        CGSize textSize = [text sizeWithFont:[textLabel font]
                constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                    lineBreakMode:[textLabel lineBreakMode]];

        [textLabel setFrame:CGRectMake(kTableCellHPadding, [imageView2 bottom] -
                kTableCellVPadding - textSize.height,
                textSize.width, textSize.height)]; 
        [textLabel sizeToFit];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setShadowColor:[UIColor darkTextColor]];
        [textLabel setShadowOffset:CGSizeMake(1, 2)];
        [contentView bringSubviewToFront:textLabel];
    }
}
@end
