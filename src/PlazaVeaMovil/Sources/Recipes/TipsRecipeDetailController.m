#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Models.h"
#import "ShoppingList/Models.h"
#import "Recipes/TipsRecipeDetailDataSource.h"
#import "Recipes/TipsRecipeDetailController.h"

@implementation TipsRecipeDetailController

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[TipsRecipeDetailDataSource alloc]
            initWithRecipeId:_recipeId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark BaseRecipeDetailController

- (void)createShoppingListFormRecipe
{
    ShoppingList *shopingList = [(Recipe *)[self model] createShoppingList];
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:nil 
            message:[NSString stringWithFormat:kRecipeDetailCreateMessage,
                [shopingList name]] delegate:self
                cancelButtonTitle:kRecipeDetailCreateButton
                otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark <RecipeDetailDataSourceDelegate>

- (void)        dataSource:(TipsRecipeDetailDataSource *)dataSource
   needsDetailImageWithURL:(NSURL *)imageURL
                     title:(NSString *)title
               andCategory:(NSString *)category
{
    if (title != nil && category != nil) {
        [self sizeTheHeaderWithImageURL:imageURL category:category
                andTitle:title];
    }
}
@end