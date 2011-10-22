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
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[StoreCollection alloc]
                initWithSubregionId:subregionId] autorelease]];
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
    NSArray *stores = [collection stores];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[stores count]];
    
    for (Store *store in stores) {
        TTTableTextItem *item = [TTTableTextItem itemWithText:[store name]];
        [items addObject:item];
    }
    [self setItems:items];
}
@end