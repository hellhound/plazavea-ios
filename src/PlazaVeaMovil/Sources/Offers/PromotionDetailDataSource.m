#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Offers/Models.h"
#import "Offers/Constants.h"
#import "Offers/PromotionDetailDataSource.h"

@implementation PromotionDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark PromotionDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithPromotionId:(NSString *)promotionId
                 delegate:(id<PromotionDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Promotion alloc] initWithPromotionId:promotionId]
                autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

#pragma mark -
#pragma mark <TTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kPromotionDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kPromotionDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return  NSLocalizedString(kPromotionDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kPromotionDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Promotion *promotion = (Promotion *)[self model];
    NSString *longDescription = [promotion longDescription];
    NSString *legalese = [promotion legalese];
    NSURL *pictureURL = [promotion bannerURL];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:5];
    
    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kPromotionDetailImageWidth,
                kPromotionDetailImageHeight);
    }
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
            andTitle:[promotion name]];
    
    TableImageSubtitleItem *legaleseItem = [TableImageSubtitleItem
            itemWithText:legalese subtitle:nil];
    TableImageSubtitleItem *descriptionItem = [TableImageSubtitleItem
            itemWithText:longDescription subtitle:nil];
    
    [items addObject:legaleseItem];
    [items addObject:descriptionItem];
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    } else if ([object isKindOfClass:[TTTableImageItem class]])
        return [OnlyImageItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end