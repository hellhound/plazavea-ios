#import <math.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "Common/Views/TableCaptionItem.h"
#import "Common/Views/TableCaptionItemCell.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kKeyWidth = 125;

@implementation TableCaptionItemCell


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString*)identifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue2
            reuseIdentifier:identifier]) {
    self.textLabel.font = TTSTYLEVAR(tableTitleFont);
    self.textLabel.textColor = TTSTYLEVAR(linkTextColor);
    self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    self.textLabel.textAlignment = UITextAlignmentRight;
    self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
    self.textLabel.numberOfLines = 1;
    self.textLabel.adjustsFontSizeToFitWidth = YES;

    self.detailTextLabel.font = TTSTYLEVAR(tableSmallFont);
    self.detailTextLabel.textColor = TTSTYLEVAR(textColor);
    self.detailTextLabel.highlightedTextColor =
            TTSTYLEVAR(highlightedTextColor);
    self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    self.detailTextLabel.minimumFontSize = 8;
    self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.detailTextLabel.numberOfLines = 0;
  }
  return self;
}

#pragma mark -
#pragma mark TTTableViewCell class public

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object
{
    TTTableCaptionItem* item = object;
    CGFloat margin = [tableView tableCellMargin];
    CGFloat width = tableView.width -
            (kKeyWidth + kKeySpacing + kTableCellHPadding * 2 + margin * 2);
    CGSize detailTextSize = [item.text sizeWithFont:TTSTYLEVAR(tableSmallFont)
            constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                lineBreakMode:UILineBreakModeWordWrap];

  return detailTextSize.height + kTableCellVPadding*2;
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
  [super layoutSubviews];

    self.textLabel.frame = CGRectMake(kTableCellHPadding, kTableCellVPadding,
            kKeyWidth, self.textLabel.font.ttLineHeight);
    CGFloat valueWidth = self.contentView.width -
            (kTableCellHPadding * 2 + kKeyWidth + kKeySpacing);
    CGFloat innerHeight = self.contentView.height - kTableCellVPadding * 2;
    self.detailTextLabel.frame =
            CGRectMake(kTableCellHPadding + kKeyWidth + kKeySpacing,
                kTableCellVPadding, valueWidth, innerHeight);
}

#pragma mark -
#pragma mark TTTableViewCell
- (void)setObject:(id)object
{
    if (_item != object) {
        [super setObject:object];

        TTTableCaptionItem* item = object;
        self.textLabel.text = item.caption;
        self.detailTextLabel.text = item.text;
    }
}

#pragma mark -
#pragma mark Public

- (UILabel*)captionLabel
{
    return self.textLabel;
}
@end
