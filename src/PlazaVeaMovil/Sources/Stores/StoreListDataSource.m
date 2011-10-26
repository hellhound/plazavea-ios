#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Stores/Constants.h"
#import "Stores/Models.h"
#import "Stores/StoreListDataSource.h"

@implementation StoreListDataSource

#pragma mark -
#pragma mark StoreListDataSource (public)

- (id)initWithSubregionId:(NSString *)subregionId
              andRegionId:(NSString *)regionId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[StoreCollection alloc] initWithSubregionId:subregionId
                andRegionId:regionId] autorelease]];
    }
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kStoreListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kStoreListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kStoreListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kStoreListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    StoreCollection *collection = (StoreCollection *)[self model];
    NSArray *sections = [collection stores];
    
    if ([sections count] > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:[sections count]];
        
        for (NSArray *section in sections) {
            NSMutableArray *sectionItems =
                    [NSMutableArray arrayWithCapacity:[sections count]];
            
            for (Store *store in section) {
                TableImageSubtitleItem *item = [TableImageSubtitleItem
                        itemWithText:[store name] subtitle:nil
                            URL:URL(kURLStoreDetailCall, [store storeId])];
                
                [sectionItems addObject:item];
            }
            [items addObject:sectionItems];
        }
        [self setSections:[[collection districts] mutableCopy]];
        [self setItems:items];
    }
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end