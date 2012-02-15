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
#import "Recipes/RecipeDetailDataSource.h"

@interface RecipeDetailDataSource (private)

- (void)setDelegate:(id<RecipeDetailDataSourceDelegate>)delegate;
@end

@implementation RecipeDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark RecipeDetailDataSource (private)

- (void)setDelegate:(id<RecipeDetailDataSourceDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark -
#pragma mark RecipeDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil){
        [self setModel:[[[Recipe alloc]
                initWithRecipeId:recipeId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               hasMeat:(BOOL)hasMeat
{
    if ((self = [super init]) != nil){
        [self setModel:[[[Recipe alloc]
                         initWithRecipeId:recipeId] autorelease]];
        [self setDelegate:delegate];
        _hasMeat = hasMeat;
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
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kRecipeDetailSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Recipe *recipe = (Recipe *)[self model];
    NSMutableArray *items = [NSMutableArray array];
    NSString *recipeName = [recipe name];
    NSString *rations = [NSString stringWithFormat:kRecipeRations,
            [[recipe rations] stringValue]];
    NSURL *pictureURL = [recipe pictureURL];

    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kRecipeDetailImageWidth,
                kRecipeDetailImageHeigth);
    }
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
        title:recipeName andCategory:rations];
    //if the features list have items doesnt show the ingredients n'
    //procedures
    if ([[recipe features] count] > 0){
        for (NSString *feature in [recipe features]) {
            TTTableTextItem *item = [TTTableTextItem itemWithText: feature];

            [items addObject:item];
        }
    } else {
        if (_hasMeat){
            if ([[recipe ingredients] count] > 0) {
                TTTableTextItem *ingredients = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionIngredients
                            URL:URL(kURLIngredientRecipeMeatsDetailCall,
                            [recipe recipeId], @"1")];
                
                [items addObject:ingredients];
            }
            if ([[recipe procedures] count] > 0) {
                TTTableTextItem *procedures = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionProcedures
                            URL:URL(kURLProceduresRecipeMeatsDetailCall,
                            [recipe recipeId], @"1")];
                
                [items addObject:procedures];
            }
            if ([[recipe tips] count] > 0) {
                TTTableTextItem *tips = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionTips
                            URL:URL(kURLTipsRecipeMeatsDetailCall,
                            [recipe recipeId], @"1")];
                
                [items addObject:tips];
            }
        } else {
            if ([[recipe ingredients] count] > 0) {
                TTTableTextItem *ingredients = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionIngredients
                            URL:URL(kURLIngredientRecipeDetailCall,
                            [recipe recipeId])];
                
                [items addObject:ingredients];
            }
            if ([[recipe procedures] count] > 0) {
                TTTableTextItem *procedures = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionProcedures
                            URL:URL(kURLProceduresRecipeDetailCall,
                            [recipe recipeId])];
                
                [items addObject:procedures];
            }
            if ([[recipe tips] count] > 0) {
                TTTableTextItem *tips = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionTips
                            URL:URL(kURLTipsRecipeDetailCall,
                            [recipe recipeId])];
                
                [items addObject:tips];
        }
        }
        TTTableTextItem *strains = [TTTableTextItem
                itemWithText:kRecipeDetailSectionStrains
                URL:URL(kURLRecipeStrainListCall, [recipe recipeId])];
        
        [items addObject:strains];
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
