#import <math.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"

static const CGFloat kKeySpacing = 12.;
static const CGFloat kDefaultImageSize = 50.;
// FIXME this accessoryView size is arbitrary
static CGSize kDefaultAccessorySize = {10., 15.};

@implementation TableImageSubtitleItemCell

#pragma mark -
#pragma mark TableImageSubtitleItemCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    TableImageSubtitleItem *item = object;    
    UIImage *image = [item imageURL] != nil ? 
            [[TTURLCache sharedCache] imageForURL:[item imageURL]] : 
            [item defaultImage];
    UIImage *accessoryImage = [item accessoryURL] != nil ? 
            [[TTURLCache sharedCache] imageForURL:[item accessoryURL]] : 
            nil;
    TTImageStyle *style = [[item imageStyle] 
            firstStyleOfClass:[TTImageStyle class]];
    CGSize imageSize = [image size];
    CGFloat imageWidth = image != nil ? imageSize.width : 
            ([item imageURL] != nil ? kDefaultImageSize : .0);
    CGFloat imageHeight = image != nil ? imageSize.height :
            ([item imageURL] != nil ? kDefaultImageSize : .0);

    if (style != nil) {
        CGSize styleSize = [style size];
        if (styleSize.width > .0)
            imageWidth = styleSize.width;
        if (styleSize.height > .0)
            imageHeight = styleSize.height;
    }
    CGSize accessorySize = accessoryImage != nil ? [accessoryImage size] :
            kDefaultAccessorySize;
    CGFloat accessoryWidth = accessorySize.width > .0 ? accessorySize.width :
                ([item accessoryURL] != nil ? kDefaultImageSize : .0);
    CGFloat accessoryHeight = accessorySize.height > .0 ? 
                accessorySize.height : 
                ([item accessoryURL] != nil ? kDefaultImageSize : .0);
    // Consider kKeySpacing between the image view and the accessory view
    CGFloat maxWidth = [tableView width] - kTableCellMargin - 
            kTableCellHPadding * 2 - imageWidth - accessoryWidth -
            kKeySpacing * 2;
    CGFloat titleHeight = [[item text] sizeWithFont:TTSTYLEVAR(tableFont)
            constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
            lineBreakMode:UILineBreakModeWordWrap].height;

    titleHeight += [[item subtitle] sizeWithFont:TTSTYLEVAR(font)
            constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
            lineBreakMode:UILineBreakModeWordWrap].height;

    CGFloat contentHeight = titleHeight > imageHeight ? 
        (titleHeight > accessoryHeight ? titleHeight : accessoryHeight) : 
        imageHeight;

    return contentHeight + kTableCellVPadding * 2.;
}

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)identifier 
{
    if (self = [super initWithStyle:UITableViewCellStyleValue2 
            reuseIdentifier:identifier]) {
        UILabel *textLabel = [self textLabel];
        UILabel *subtitleLabel = [self subtitleLabel];

        [textLabel setFont:TTSTYLEVAR(tableFont)];
        [textLabel setTextColor:TTSTYLEVAR(textColor)];
        [textLabel 
                setHighlightedTextColor:TTSTYLEVAR(highlightedTextColor)];
        //[textLabel setAdjustsFontSizeToFitWidth:YES];
        [textLabel setLineBreakMode:UILineBreakModeWordWrap];
        [textLabel setNumberOfLines:0];

        [subtitleLabel setFont:TTSTYLEVAR(font)];
        [subtitleLabel setTextColor:TTSTYLEVAR(tableSubTextColor)];
        [subtitleLabel 
                setHighlightedTextColor:TTSTYLEVAR(highlightedTextColor)];
        [subtitleLabel setTextAlignment:UITextAlignmentLeft];
        [subtitleLabel setContentMode:UIViewContentModeTop];
        [subtitleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [subtitleLabel setNumberOfLines:0];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    TableImageSubtitleItem *item = [self object];
    UIView *contentView = [self contentView];
    TTImageView *imageView = [self imageView2];
    UILabel *textLabel = [self textLabel];
    UILabel *subtitleLabel = [self subtitleLabel];
    UIImage *image = [item imageURL] != nil ? 
            [[TTURLCache sharedCache] imageForURL:item.imageURL] : 
            [item defaultImage];
    NSString *subtitleText = [subtitleLabel text];
    CGFloat innerWidth = .0;
    CGFloat imageWidth = .0, imageHeight = .0;

    if ([imageView urlPath] != nil || [imageView defaultImage] != nil) {
        NSString *imageURL = [item imageURL];
        CGSize imageSize = [image size];
        TTImageStyle *style = [[item imageStyle] 
                firstStyleOfClass:[TTImageStyle class]];

        imageWidth = image != nil ? imageSize.width : 
                (imageURL != nil ? kDefaultImageSize : .0);
        imageHeight = image != nil ? imageSize.height :
                (imageURL != nil ? kDefaultImageSize : .0);
        if (style != nil) {
            CGSize styleSize = [style size];

            [imageView setContentMode:[style contentMode]];
            [imageView setClipsToBounds:YES];
            [imageView setBackgroundColor:[UIColor clearColor]];
            if (styleSize.width > .0)
                imageWidth = styleSize.width;
            if (styleSize.height > .0)
                imageHeight = styleSize.height;
        }
        [imageView setFrame:CGRectMake(kTableCellHPadding, kTableCellVPadding, 
                imageWidth, imageHeight)];
        innerWidth = [contentView width] - kTableCellHPadding - imageWidth -
                kKeySpacing * 2.;
    } else {
        [imageView setFrame:CGRectZero];
    } 
    if ([subtitleText length] == 0) {
        CGFloat maxWidth = innerWidth > .0 ? innerWidth :
                [contentView width] - kTableCellHPadding * 2.;
        CGSize titleSize = [[textLabel text] sizeWithFont:[textLabel font] 
                constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                lineBreakMode:[textLabel lineBreakMode]];

        [textLabel setFrame:
            CGRectMake(kTableCellHPadding + imageWidth +
                (imageWidth > .0 ? kKeySpacing : .0), 
                kTableCellVPadding, titleSize.width, titleSize.height)];
    } else {
        CGFloat maxWidth = innerWidth > .0 ? innerWidth :
                [contentView width] - kTableCellHPadding * 2.;
                
        CGSize titleSize = [[textLabel text] sizeWithFont:[textLabel font] 
                constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                lineBreakMode:[textLabel lineBreakMode]];
        CGSize subtitleSize = [subtitleText sizeWithFont:[subtitleLabel font] 
                constrainedToSize:CGSizeMake(maxWidth, [contentView height] -
                        kTableCellVPadding * 2. - titleSize.height)
                lineBreakMode:[subtitleLabel lineBreakMode]];

        [textLabel setFrame:
            CGRectMake(kTableCellHPadding + imageWidth + kKeySpacing, 
                kTableCellVPadding, titleSize.width, titleSize.height)];
        [textLabel sizeToFit];
        [subtitleLabel setFrame:
            CGRectMake(kTableCellHPadding + imageWidth + kKeySpacing, 
                [textLabel bottom], subtitleSize.width, subtitleSize.height)];
        [subtitleLabel sizeToFit];
    }
}
@end
