#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
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
    return [(RecipeCollection *)[self model] sectionIndexTitles];;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRecipesTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRecipesTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRecipesSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRecipesTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return NSLocalizedString(kRecipesSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    RecipeCollection *collection = (RecipeCollection *)[self model];
    NSArray *sections = [collection sections];
    NSUInteger sectionCount = [sections count], i;
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:sectionCount];

    for (i = 0; i < sectionCount; i++)
        [items addObject:[sections objectAtIndex:i]];
    [self setSections:[[collection sectionTitles] mutableCopy]];
    [self setItems:items];
}
@end
