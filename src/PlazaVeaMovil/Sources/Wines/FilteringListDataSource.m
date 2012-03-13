#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/FilteringListDataSource.h"

@implementation FilteringListDataSource

#pragma mark -
#pragma mark FilteringListDataSource

@synthesize list = _list, controller = _controller;

- (id)initWithList:(WineFilteringListType)list controller:(id)controller
{
    if ((self = [super init]) != nil) {
        _list = list;
        _controller = controller;
        [self setModel:[[[FilterCollection alloc] initWithCollectionId:_list]
                autorelease]];
    }
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kFilteringListTitleForLoading, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kFilteringListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kFilteringListSubtitleForError, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kFilteringListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kFilteringListSubtitleForEmpty, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSMutableArray *items = [NSMutableArray array];
    FilterCollection *collection = (FilterCollection *)[self model];
    
    for (Winery *rawItem in [collection list]) {
        TableImageSubtitleItem *item = [TableImageSubtitleItem
                itemWithText:[rawItem name] delegate:_controller
                    selector:@selector(back:)];
        
        [items addObject:item];
        //[item setItemId:[rawItem wineryId]];
        [item setExtra:rawItem];
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