#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
    return NSLocalizedString(kRecipeListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRecipeListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRecipeListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    // TODO should show an iOS error
    return NSLocalizedString(kRecipeListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    // TODO should show an iOS error
    return NSLocalizedString(kRecipeListSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    RecipeCollection *collection = (RecipeCollection *)[self model];
    NSArray *sections = [collection sections];
    NSUInteger sectionCount = [sections count], i;

    if (sectionCount > 0) {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:sectionCount];

        for (i = 0; i < sectionCount; i++)
            [items addObject:[sections objectAtIndex:i]];
        [self setSections:[[collection sectionTitles] mutableCopy]];
        [self setItems:items];
    }
}
@end
