#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableCaptionItemCell.h"
#import "Common/Views/TableCaptionItem.h"
#import "Offers/Models.h"
#import "Offers/Constants.h"
#import "Offers/OfferDetailDataSource.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat kShareLabelFont = 14.;
static CGFloat kButtonHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation OfferDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}
#pragma mark -
#pragma mark OfferDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithOfferId:(NSString *)offerId
              delegate:(id<OfferDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Offer alloc] initWithOfferId:offerId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    TTImageView *imageView = nil;
    if (imageURL != nil) {
        imageView = [[[TTImageView alloc] initWithFrame:CGRectZero]
                autorelease];
        
        [imageView setDefaultImage:TTIMAGE(kPromotionListDefaultBanner)];
        [imageView setUrlPath:imageURL];
        [imageView setAutoresizingMask:UIViewAutoresizingNone];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [imageView setBackgroundColor:[UIColor clearColor]];
    }
    // Conf the label
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorYellow)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    
    UIFont *font = [titleLabel font];
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2.)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2.;
        titleHeight = headerMinHeight - (margin * 2.);
    } else {
        titleFrame.origin.y += margin;
    }
    [titleLabel setText:title];
    [titleLabel setFrame:titleFrame];
    // Conf the buttons
    UILabel *shareLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    
    [shareLabel setFont:[UIFont boldSystemFontOfSize:kShareLabelFont]];
    [shareLabel setText:kOfferDetailShare];
    [shareLabel setBackgroundColor:[UIColor clearColor]];
    
    CGFloat shareLabelWidth =
            [[shareLabel text] sizeWithFont:[shareLabel font]].width;
    
    [shareLabel setFrame:CGRectMake(.0, .0,
            shareLabelWidth, kButtonHeight)];
    
    UIButton *mailButton = [[[UIButton alloc] initWithFrame:
            CGRectMake(.0, .0, kButtonHeight, kButtonHeight)] autorelease];
    
    [mailButton setImage:TTIMAGE(kOfferDetailMailImage)
            forState:UIControlStateNormal];
    [mailButton addTarget:_delegate action:@selector(mailOffer)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *facebookButton = [[[UIButton alloc] initWithFrame:
            CGRectMake(.0, .0, kButtonHeight, kButtonHeight)] autorelease];
    
    [facebookButton setImage:TTIMAGE(kOfferDetailFacebookImage)
            forState:UIControlStateNormal];
    [facebookButton addTarget:_delegate action:@selector(likeOffer)
             forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *twitterButton = [[[UIButton alloc] initWithFrame:
            CGRectMake(.0, .0, kButtonHeight, kButtonHeight)] autorelease];
    
    [twitterButton setImage:TTIMAGE(kOfferDetailTwitterImage)
            forState:UIControlStateNormal];
    [twitterButton addTarget:_delegate action:@selector(showTwitterAlert)
            forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat x = [shareLabel frame].size.width + margin;
    
    [mailButton setFrame:CGRectOffset([mailButton frame], x, .0)];
    
    x += [mailButton frame].size.width + margin;
    
    [facebookButton setFrame:CGRectOffset([facebookButton frame], x, .0)];
    
    x += [facebookButton frame].size.width + margin;
    
    [twitterButton setFrame:CGRectOffset([twitterButton frame], x, .0)];
    
    x += [twitterButton frame].size.width;
    CGFloat leftMargin = (titleWidth - x) / 2;
    UIView *share = [[[UIView alloc] initWithFrame:
            CGRectMake(leftMargin, .0, x, kButtonHeight)] autorelease];
    UIView *whiteBackground =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    [whiteBackground setBackgroundColor:[UIColor whiteColor]];
    //[share setTag:kShareTag];
    [share addSubview:shareLabel];
    [share addSubview:mailButton];
    [share addSubview:facebookButton];
    [share addSubview:twitterButton];
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth,
            [imageView frame].size.height + titleHeight +
                [share frame].size.height + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];
    [whiteBackground setFrame:CGRectMake(.0, titleHeight + (margin * 2.),
            titleWidth, [headerView frame].size.height -
                [share frame].size.height)];
    [share setFrame:CGRectOffset([share frame], .0,
            [headerView frame].size.height - [share frame].size.height)];
    [headerView addSubview:whiteBackground];
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    [headerView addSubview:share];
    
    UIImageView *background = [[[UIImageView alloc] initWithImage:
            (UIImage *)TTSTYLE(offerBackgroundHeader)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kOfferDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return  NSLocalizedString(kOfferDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kOfferDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kOfferDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Offer *offer = (Offer *)[self model];
    NSURL *pictureURL = [offer pictureURL];
    
    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kOfferDetailImageWidth,
                kOfferDetailImageHeight);
    }
    [_delegate dataSource:self needsOffer:offer];
    [_delegate dataSource:self viewForHeader:[self viewWithImageURL:
            [pictureURL absoluteString] title:[offer name]]];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:5];
    
    if ([offer oldPrice] != nil) {
        TableCaptionItem *oldPrice = [TableCaptionItem itemWithText:
                [NSString stringWithFormat:kOfferDetailPricePrefix,
                    [[offer oldPrice] floatValue]]
                    caption:kOfferDetailOldPriceCaption];
        
        [items addObject:oldPrice];
    }
    if ([offer price] != nil) {
        TableCaptionItem *price = [TableCaptionItem itemWithText:
                [NSString stringWithFormat:kOfferDetailPricePrefix,
                    [[offer price] floatValue]]
                    caption:kOfferDetailPriceCaption];
        
        [items addObject:price];
    }
    if (([offer validFrom] != nil) && ([offer validTo] != nil)) {
        NSDateFormatter *dateFormatter =
                [[[NSDateFormatter alloc] init] autorelease];
        
        [dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
        NSString *validString = [NSString stringWithFormat:
                kOfferDetailValidPrefix,
                    [dateFormatter stringFromDate:[offer validFrom]],
                    [dateFormatter stringFromDate:[offer validTo]]];
        TableCaptionItem *valid = [TableCaptionItem itemWithText:validString
                caption:kOfferDetailValidCaption];
                                   
        [items addObject:valid];
    }
    if ([offer longDescription] != nil) {
        TableImageSubtitleItem *longDescription = [TableImageSubtitleItem
                itemWithText:[offer longDescription] subtitle:nil];

        [items addObject:longDescription];
    }
    if ([offer legalese] != nil) {
        TTTableSubtextItem *legalese =
                [TTTableSubtextItem itemWithText:kOfferDetailLegaleseCaption
                        caption:[offer legalese]];
        
        [items addObject:legalese];
    }
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    if ([object isKindOfClass:[TableCaptionItem class]])
        return [TableCaptionItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end
