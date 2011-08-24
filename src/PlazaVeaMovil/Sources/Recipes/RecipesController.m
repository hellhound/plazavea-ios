#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/AlphabeticalRecipesDataSource.h"
#import "Recipes/RecipesController.h"

@implementation RecipesController

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[AlphabeticalRecipesDataSource alloc] init] autorelease]];
}
@end
