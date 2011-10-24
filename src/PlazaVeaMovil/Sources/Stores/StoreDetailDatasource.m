#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"

#import "Stores/Models.h"
#import "Stores/Constants.h"
#import "Stores/StoreDetailDataSource.h"

@implementation StoreDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark StoreDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithStoreId:(NSString *)storeId
              delegate:(id<StoreDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Store alloc] initWithStoreId:storeId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kStoreDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return  NSLocalizedString(kStoreDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kStoreDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kStoreDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{

}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end
