#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"
#import "Recipes/RecipesController.h"

@implementation RecipesController

#pragma mark -
#pragma mark TTViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:kRecipesTitle];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[AlphabeticalRecipesDataSource alloc] init] autorelease]];
}
@end
