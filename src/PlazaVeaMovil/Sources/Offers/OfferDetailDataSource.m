#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
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
    NSString *longDescription = [offer longDescription];
    NSURL *pictureURL = [offer pictureURL];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:5];
    
    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kOfferDetailImageWidth,
                kOfferDetailImageHeight);
    }
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
            andTitle:[offer name]];

    TableImageSubtitleItem *item = [TableImageSubtitleItem
            itemWithText:longDescription subtitle:nil];

    [items addObject:item];
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end
