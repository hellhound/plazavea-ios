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
    if ([self isMeat]) {
        [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                initWithMeatId:_collectionId] autorelease]];
    } else {
        [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                initWithCategoryId:_collectionId] autorelease]];
    }
}

#pragma mark -
#pragma mark RecipeListController (Public)

@synthesize collectionId = _collectionId, isMeat = _isMeat;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [categoryId copy];
        _isMeat = NO;
        [self setTitle:NSLocalizedString(kRecipeListTitle, nil)];
    }
    return self;
}

- (id)initWithMeatId:(NSString *)meatId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [meatId copy];
        _isMeat = YES;
        [self setTitle:NSLocalizedString(kRecipeListTitle, nil)];
    }
    return self;
}
@end
