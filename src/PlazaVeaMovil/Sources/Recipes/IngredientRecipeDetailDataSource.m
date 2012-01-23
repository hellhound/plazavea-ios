#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/IngredientRecipeDetailDataSource.h"

@interface IngredientRecipeDetailDataSource (private)

- (void)setDelegate:(id<IngredientRecipeDetailDataSourceDelegate>)delegate;
@end

@implementation IngredientRecipeDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark RecipeDetailDataSource (private)

- (void)setDelegate:(id<IngredientRecipeDetailDataSourceDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark -
#pragma mark RecipeDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<IngredientRecipeDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil){
        [self setModel:[[[Recipe alloc]
                initWithRecipeId:recipeId] autorelease]];
        [self setDelegate:delegate];
        
    }
    return self;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRecipeDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRecipeDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRecipeDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRecipeDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void) tableViewDidLoadModel:(UITableView *)tableView
{
    Recipe *recipe = (Recipe *)[self model];
    NSMutableArray *items = [NSMutableArray array];
    NSString *recipeName = [recipe name];
    NSString *title = [NSString stringWithFormat:kRecipeRations, recipeName,
            [[recipe rations] stringValue]];
    NSURL *pictureURL = [recipe pictureURL];
    
    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kRecipeDetailImageWidth,
                kRecipeDetailImageHeigth);
    }
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
            title:title andCategory:kRecipeDetailSectionIngredients];
    if ([[recipe ingredients] count] > 0) {
        for (Ingredient *ingredient in [recipe ingredients]) {
            TTTableLongTextItem *item = [TTTableLongTextItem 
                    itemWithText: [ingredient formattedIngredientString]];
            
            [items addObject:item];
        }
    }
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end