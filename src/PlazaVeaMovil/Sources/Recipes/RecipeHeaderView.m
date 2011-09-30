#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Headers/Recipe/RecipeHeaderView.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageSize = 50;

@implementation RecipeHeaderView

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

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    UIView *contentView = [self contentView];
    UIView *imageView2 = [self imageView2];
    UILabel *textLabel = [self textLabel];
    NSString *text = [textLabel text];

    [contentView sizeToFit];
    [imageView2 sizeToFit];

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
        [textLabel setBackgroundColor:TTSTYLEVAR(textOverlayBackgroundColor)];
        [textLabel setTextColor:TTSTYLEVAR(textOverlayColor)];
        [textLabel setShadowColor:TTSTYLEVAR(textOverlayShadowColor)];
        [textLabel setShadowOffset:TTSTYLEVAR(textOverlayShadowOffset)];
        [contentView bringSubviewToFront:textLabel];
    }
}

#pragma mark -
#pragma mark RecipeHeaderView (Public)

@synthesize imageURL = _imageURL, defaultImageURL = _defaultImageURL,
        imageStyle = _imageStyle, text = _text, textStyle = _textStyle;

+ (id)recipeHeaderViewWithImageURL:(NSURL *)imageURL
                   defaultImageURL:(NSURL *)defaultImageURL
                        imageStyle:(TTImageStyle *)imageStyle
                              text:(NSString *)text
                         textStyle:(TTTextStyle *)textStyle
{
    return [[[RecipeHeaderView alloc] initWithImageURL:imageURL
            defaultImageURL:defaultImageURL imageStyle:imageStyle
            text:text textStyle:textStyle] autorelease];
}

- (id)initWithImageURL:(NSURL *)imageURL
       defaultImageURL:(NSURL *)defaultImageURL
            imageStyle:(TTImageStyle *)imageStyle
                  text:(NSString *)text
             textStyle:(TTTextStyle *)textStyle
{
    if ((self = [self initWithFrame:rect]) != nil) {
        [self setImageURL:imageURL];
        [self setDefaultImageURL:defaultImageURL];
        [self setImageStyle:imageStyle];
        [self setText:text];
        [self setTextStyle:textStyle];

        UIImage *defaultImage = TTIMAGE([defaultURL absoluteString]);
    }
    return self;
}
@end
