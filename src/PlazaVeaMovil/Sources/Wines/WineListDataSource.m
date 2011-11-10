#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Wines/Constants.h"
#import "Wines/Models.h"
#import "Wines/WineListDataSource.h"

@implementation WineListDataSource

#pragma mark -
#pragma mark StoreListDataSource (public)


- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[WineCollection alloc] initWithCategoryId:categoryId]
                autorelease]];
    }
    return self;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [(WineCollection *)[self model] sectionIndexTitles];
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kWineListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kWineListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kWineListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kWineListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    WineCollection *collection = (WineCollection *)[self model];
    NSArray *sections = [collection sections];
    
    if ([sections count] > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:[sections count]];
        
        for (NSArray *section in sections) {
            NSMutableArray *sectionItems =
            [NSMutableArray arrayWithCapacity:[sections count]];
            
            for (Wine *wine in section) {
                TableImageSubtitleItem *item = [TableImageSubtitleItem
                        itemWithText:[wine name] subtitle:nil
                            URL:URL(kURLWineDetailCall, [wine wineId])];
                
                [sectionItems addObject:item];
            }
            [items addObject:sectionItems];
        }
        [self setSections:[[collection sectionTitles] mutableCopy]];
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