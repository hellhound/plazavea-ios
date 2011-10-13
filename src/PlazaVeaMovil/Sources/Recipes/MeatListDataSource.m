#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/MeatListDataSource.h"

@implementation MeatListDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[MeatCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kMeatsListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kMeatsListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kMeatsListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kMeatsListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

#pragma mark -
#pragma mark TTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSArray *meats = [(MeatCollection *)[self model] meats];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[meats count]];
    for (Meat *meat in meats) {
        TableImageSubtitleItem *item = [TableImageSubtitleItem
                itemWithText:[meat name] subtitle:nil
                imageURL:[meat pictureURL]
                defaultImage:TTIMAGE(kRecipeListDefaultImage)
                URL:URL(kURLRecipeMeatListCall, [meat meatId])];
        [items addObject:item];
    }
    [self setItems:items];
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
