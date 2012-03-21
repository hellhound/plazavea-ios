#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Offers/Models.h"
#import "Offers/Constants.h"
#import "Offers/OfferListDataSource.h"

@implementation OfferListDataSource

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark OfferListDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithListDelegate:(id<OfferListDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[OfferCollection alloc] init] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kOfferListTitleForLoading, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kOfferListTitleForError, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kOfferListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kOfferListSubtitleForEmpty, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kOfferListSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    OfferCollection *offerCollection = (OfferCollection *)[self model];
    NSArray *offers = [offerCollection offers];
    Banner *banner = [offerCollection banner];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[offers count]];
    NSURL *bannerImageURL = [banner pictureURL];
    NSNumber *bannerId = [banner bannerId];
    
    if (bannerImageURL != nil) {
        [_delegate dataSource:self needsBannerId:bannerId];

        bannerImageURL = IMAGE_URL(bannerImageURL, kBannerImageWidth,
                kBannerImageHeight);
    }
    TTTableImageItem *bannerCell = [TTTableImageItem itemWithText:nil
            imageURL:[bannerImageURL absoluteString] defaultImage:
                TTIMAGE(kOfferBannerDefaultImage) URL:nil];

    [items addObject:bannerCell];
    for (Offer *offer in offers) {
        NSURL *pictureURL = [offer pictureURL];
        
        if (pictureURL != nil) {
            pictureURL = IMAGE_URL([offer pictureURL], kOfferListImageWidth,
                    kOfferListImageHeight);
        }
        NSString *offerText = [NSString stringWithFormat:@"%@%@%.2f",
                [offer name], kOfferListPriceTag, [[offer price] floatValue]];
        
        TableImageSubtitleItem *item = [TableImageSubtitleItem
                itemWithText:offerText subtitle:nil
                    imageURL:[pictureURL absoluteString]
                    defaultImage:TTIMAGE(kOfferListDefaultImage)
                    URL:URL(kURLOfferDetailCall, [offer offerId])];
        [items addObject:item];
    }
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    } else if ([object isKindOfClass:[TTTableImageItem class]]) {
        return [OnlyImageItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
