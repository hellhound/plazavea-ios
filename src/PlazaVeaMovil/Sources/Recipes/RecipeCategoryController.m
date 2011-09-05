#import <Foundation/Foundation.h>

#import "Recipes/Constants.h"
#import "Recipes/RecipeCategoryDataSource.h"
#import "Recipes/RecipeCategoryController.h"

@implementation RecipeCategoryController

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTitle:NSLocalizedString(kRecipeCategoryTitle, nil)];
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[RecipeCategoryDataSource alloc] init] autorelease]];
}
@end
