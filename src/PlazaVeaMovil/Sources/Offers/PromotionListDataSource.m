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
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kPromotionListSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
    NSArray *promotions = [(PromotionCollection *)[self model] promotions];
    NSUInteger promotionCount = [promotions count];

    if (promotionCount > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:promotionCount];
        NSMutableArray *imageItems =
                [NSMutableArray arrayWithCapacity:promotionCount];
        UIImage *defaultImage = TTIMAGE(kBannerDefaultImage);

        for (Promotion *promotion in promotions) {
            NSString *URL = URL(kURLPromotionDetailCall,
                    [promotion promotionId]); 
            TableImageSubtitleItem *item = [TableImageSubtitleItem
                    itemWithText:[promotion name] URL:URL];
            NSURL *bannerURL = [promotion bannerURL];

            [items addObject:item];
            if (bannerURL != nil) {
                TableImageSubtitleItem *imageItem =
                        [TableImageSubtitleItem itemWithText:nil subtitle:nil
                            imageURL:[IMAGE_URL(bannerURL,
                                kPromotionListImageWidth,
                                kPromotionListImageHeight) absoluteString]
                                defaultImage:defaultImage URL:URL];
                [imageItems addObject:imageItem];
            }
        }
        if ([imageItems count] > 0) {
            ImageCarouselItem *carousel =
                    [ImageCarouselItem itemWithImageItems:imageItems];

            [carousel setDefaultImage:defaultImage];
            [items insertObject:carousel atIndex:0];
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
