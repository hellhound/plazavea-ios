#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/AlphabeticalRecipesDataSource.h"

@implementation AlphabeticalRecipesDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
    }
    return self;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return @"";
}

- (NSString *)titleForEmpty
{
    return @"";
}

- (NSString *)titleForError:(NSError *)error
{
    return @"";
}

- (NSString *)subtitleForError:(NSError *)error
{
    return @"";
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
}
@end
