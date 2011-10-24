#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/ImageCarouselItem.h"
#import "Common/Views/ImageCarouselItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/PromotionListDataSource.h"

@implementation PromotionListDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[PromotionCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kPromotionListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kPromotionListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kPromotionListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kPromotionListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSArray *promotions = [(PromotionCollection *)[self model] promotions];
    NSUInteger promotionCount = [promotions count];

    if (promotionCount > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:promotionCount];

        for (Promotion *promotion in promotions) {
            TableImageSubtitleItem *item = [TableImageSubtitleItem
                    itemWithText:[promotion name] URL:
                        URL(kURLPromotionDetailCall, [promotion promotionId])];

            [items addObject:item];
        }
        [self setItems:items];
    }
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    } else if ([object isKindOfClass:[ImageCarouselItem class]]) {
        return [ImageCarouselItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
