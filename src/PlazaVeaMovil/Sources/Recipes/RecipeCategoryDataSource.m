#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/RecipeCategoryDataSource.h"

@implementation RecipeCategoryDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[RecipeCategoryCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark TTTableViewDataSource

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRecipeCategoryTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRecipeCategoryTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRecipeCategorySubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRecipeCategoryTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kRecipeCategorySubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
    NSArray *categories = [(RecipeCategoryCollection *)[self model] categories];
    NSUInteger categoryCount = [categories count];

    if (categoryCount > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:categoryCount];

        for (RecipeCategory *category in categories) {
            BOOL flag = NO;
            TTTableTextItem *item;
            NSString *name = [[category name]
                    stringByReplacingOccurrencesOfString:@" " withString:@"_"];
            if (([[category subcategoriesCount] integerValue] == 0) &&
                        ([[category recipeCount] integerValue] > 0)) {
                item = [TTTableTextItem itemWithText:[category name]
                        URL:URL(kURLRecipeListCall, [category categoryId],
                            name)];
                flag = YES;
            } else if ([[category subcategoriesCount] integerValue] > 0) {
                item = [TTTableTextItem itemWithText:[category name]
                        URL:URL(kURLRecipeSubCategoriesCall, 
                            [category categoryId])];
                flag = YES;
            }
            if (flag) 
                [items addObject:item];
        }
        [self setItems:items];
    }
}

#pragma mark -
#pragma mark RecipeCategoryDataSource

- (id)initWithCategoryId:(NSString *)categoryId{
    if ((self = [super init]) != nil)
        [self setModel:[[[RecipeCategoryCollection alloc]
                initWithCategoryId:categoryId] autorelease]];
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
