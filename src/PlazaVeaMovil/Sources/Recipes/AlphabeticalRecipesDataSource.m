#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Models.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"

@implementation AlphabeticalRecipesDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[RecipeCollection alloc] init] autorelease]];
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
    return @"Loading...";
}

- (NSString *)titleForEmpty
{
    return @"Empty";
}

- (NSString *)titleForError:(NSError *)error
{
    return @"Error";
}

- (NSString *)subtitleForError:(NSError *)error
{
    return @"lulwut?";
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSMutableArray *sections = [NSMutableArray arrayWithObject:@"Prueba"];
    NSMutableArray *items = [NSMutableArray array];

    for (Recipe *recipe in [(RecipeCollection *)[self model] recipes]) {
        TTTableTextItem *item = [TTTableTextItem itemWithText:[recipe name]];
        [items addObject:item];
    }
    [self setSections:sections];
    [self setItems:[NSArray arrayWithObject:items]];
}
@end
