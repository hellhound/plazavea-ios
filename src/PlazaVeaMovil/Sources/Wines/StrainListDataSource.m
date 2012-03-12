#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/OnlyImageItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/StrainListDataSource.h"

@implementation StrainListDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[StrainCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark StrainListDataSource

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [super init]) != nil)
        [self setModel:[[[StrainCollection alloc] initWithRecipeId:recipeId]
                autorelease]];
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kStrainListTitleForLoading, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kStrainListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kStrainListSubtitleForError, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kStrainListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kStrainListSubtitleForEmpty, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    StrainCollection *collection = (StrainCollection *)[self model];
    NSArray *strains = [collection strains];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[strains count]];
    
    for (Strain *strain in strains) {
        NSString *name = [strain name];
        TableImageSubtitleItem *item = [TableImageSubtitleItem itemWithText:name
                subtitle:nil URL:URL(kURLWineListCall, [strain strainId])];
        
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