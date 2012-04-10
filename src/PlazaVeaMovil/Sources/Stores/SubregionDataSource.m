#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Stores/Models.h"
#import "Stores/Constants.h"
#import "Stores/SubregionDataSource.h"

@implementation SubregionDataSource

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRegionListTitleForLoading, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRegionListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kRegionListSubtitleForError, nil);
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
    if ([[self items] count] > 0) {
        return;
    }
    SubregionCollection *regionCollection = (SubregionCollection *)[self model];
    NSArray *subregions = [regionCollection subregions];
    NSMutableArray *items =
            [NSMutableArray arrayWithCapacity:[subregions count]];
    
    for (Subregion *subregion in subregions) {
        NSString *name = [subregion name];
        
        TableImageSubtitleItem *item = [TableImageSubtitleItem
                itemWithText:name subtitle:nil URL:URL(kURLStoreListCall,
                    [subregion subregionId], _regionId, [subregion name])];
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

#pragma mark -
#pragma mark RegionListDataSource (Public)

@synthesize regionId = _regionId;

- (id)initWithRegionId:(NSString *)regionId {
    if ((self = [super init]) != nil) {
        _regionId = [regionId copy];
        [self setModel:[[[SubregionCollection alloc] initWithRegionId:regionId]
                        autorelease]];
    }
    return self;
}
@end
