#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Offers/Models.h"
#import "Offers/Constants.h"
#import "Offers/OfferListDataSource.h"

@implementation OfferListDataSource

#pragma mark -
#pragma mark OfferListDataSource (public)


- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[OfferCollection alloc] init] autorelease]];
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
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

#pragma mark -
#pragma mark TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSArray *offers = [(OfferCollection *)[self model] offers];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[offers count]];
    NSURL *bannerImageURL = [[(OfferCollection *)[self model] banner]
                             pictureURL];
    TTTableImageItem *banner = [TTTableImageItem itemWithText:nil imageURL:
        [bannerImageURL absoluteString] defaultImage:
            TTIMAGE(kBannerDefaultImage) URL:nil];

    [items addObject:banner];
    for (Offer *offer in offers) {
        TableImageSubtitleItem *item = [TableImageSubtitleItem
                itemWithText:[offer name] subtitle:nil
                    imageURL:[[offer pictureURL] absoluteString]
                    defaultImage:TTIMAGE(kOfferListDefaultImage) URL:nil];
        [items addObject:item];
    }
    [self setItems:items];
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

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