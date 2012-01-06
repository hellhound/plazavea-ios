#import <Foundation/Foundation.h>

#import "Wines/Constants.h"
#import "Wines/StrainListDataSource.h"
#import "Wines/StrainListController.h"

@implementation StrainListController

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kStrainListTitle];
        [self setVariableHeightRows:YES];
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if (_recipeId != nil) {
        [self setDataSource:[[[StrainListDataSource alloc]
                initWithRecipeId:_recipeId] autorelease]];
    } else {
        [self setDataSource:[[[StrainListDataSource alloc] init] autorelease]];
    }
}

#pragma mark -
#pragma mark StrainListController

@synthesize recipeId = _recipeId;

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        [self setTitle:kStrainListTitle];
        [self setVariableHeightRows:YES];
        _recipeId = recipeId;
    }
    return self;
}
@end
