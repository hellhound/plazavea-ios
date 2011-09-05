#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"
#import "Recipes/RecipeListController.h"

@implementation RecipeListController

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
            initWithCategoryId:_categoryId] autorelease]];
}

#pragma mark -
#pragma mark RecipeListController (Public)

@synthesize categoryId = _categoryId;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _categoryId = [categoryId copy];
        [self setTitle:NSLocalizedString(kRecipeListTitle, nil)];
    }
    return self;
}
@end
