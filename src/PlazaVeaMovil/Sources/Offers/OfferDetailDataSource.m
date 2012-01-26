#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableCaptionItemCell.h"
#import "Common/Views/TableCaptionItem.h"
#import "Offers/Models.h"
#import "Offers/Constants.h"
#import "Offers/OfferDetailDataSource.h"

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
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
            andTitle:[offer name]];
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
        TTTableLongTextItem *legalese =
                [TTTableLongTextItem itemWithText:[offer legalese]];
        
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
