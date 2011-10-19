#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Stores/Models.h"
#import "Stores/Constants.h"
#import "Stores/RegionListDataSource.h"

@implementation RegionListDataSource

#pragma mark -
#pragma mark RegionListDataSource

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[RegionCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRegionListTitleForLoading, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRegionListSubtitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRegionListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRegionListSubtitleForEmpty, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    RegionCollection *regionCollection = (RegionCollection *)[self model];
    NSArray *regions = [regionCollection regions];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[regions count]];
    
    for (Region *region in regions) {
        NSString *name = [region name];
        
        TableImageSubtitleItem *item = [TableImageSubtitleItem itemWithText:name
                subtitle:nil URL:nil];
        [items addObject:item];
    }
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end