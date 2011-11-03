#import <Foundation/Foundation.h>

#import "Recipes/Constants.h"
#import "Recipes/RecipeCategoryDataSource.h"
#import "Recipes/RecipeCategoryController.h"

@implementation RecipeCategoryController

#pragma mark -
#pragma mark UIView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

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
    if (_categoryId == nil) {
        [self setDataSource:
                [[[RecipeCategoryDataSource alloc] init] autorelease]];
    }
    else {
        [self setDataSource:
                [[[RecipeCategoryDataSource alloc]
                        initWithCategoryId:_categoryId] autorelease]];
    }
}

#pragma mark -
#pragma mark RecipeCategoryController (Public)

@synthesize categoryId = _categoryId;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil){
        _categoryId = [categoryId copy];
        [self setTitle:NSLocalizedString(kRecipeSubcategoryTitle, nil)];
    }
    return self;
}
@end
