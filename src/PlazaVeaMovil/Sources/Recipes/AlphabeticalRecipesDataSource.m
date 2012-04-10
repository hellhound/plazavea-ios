#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"

@implementation AlphabeticalRecipesDataSource

#pragma mark -
#pragma mark AlphabeticalRecipesDataSource

@synthesize from = _from;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[RecipeCollection alloc]
                initWithCategoryId:categoryId] autorelease]];
        _from = kRecipeFromCategory;
    } 
    return self;
}

- (id)initWithMeatId:(NSString *)meatId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[RecipeCollection alloc]
                initWithMeatId:meatId] autorelease]];
        _from = kRecipeFromMeat;
    }
    return self;
}

- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[RecipeCollection alloc]
                initWithWineId:wineId] autorelease]];
        _from = kRecipeFromWine;
    }
    return self;
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [(RecipeCollection *)[self model] sectionIndexTitles];
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
    return NSLocalizedString(kRecipeListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kRecipeListSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
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

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
