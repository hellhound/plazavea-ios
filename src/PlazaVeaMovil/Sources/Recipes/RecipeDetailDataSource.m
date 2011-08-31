#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/RecipeDetailDataSource.h"

@implementation RecipeDetailDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    return [super init];
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return nil;
}

- (NSString *)titleForEmpty
{
    return nil;
}

- (NSString *)subtitleForEmpty
{
    return nil;
}

- (NSString *)titleForError:(NSError *)error
{
    return nil;
}

- (NSString *)subtitleForError:(NSError *)error
{
    return nil;
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
}
@end
