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

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Recipe *recipe = (Recipe *)[self model];
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *sections = [NSMutableArray array];
    NSString *recipeName = [recipe name];
    NSString *title = [NSString stringWithFormat:kRecipeRations, recipeName,
            [[recipe rations] stringValue]];
    NSURL *pictureURL = [recipe pictureURL];

    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kRecipeDetailImageWidth,
                kRecipeDetailImageHeigth);
    }
    [_delegate dataSource:self needsDetailImageWithURL:pictureURL
        title:title andCategory:[[recipe category] name]];
    //if the features list have items doesnt show the ingredients n'
    //procedures
    if ([[recipe features] count] > 0){
        /*NSMutableArray *subitems = [NSMutableArray array];

        [sections addObject:
                NSLocalizedString(kRecipeDetailSectionFeatures, nil)];*/
        for (NSString *feature in [recipe features]) {
            TTTableTextItem *item = [TTTableTextItem itemWithText: feature];

            [items addObject:item];
        }
        //[items addObject:subitems];
    } else {
        /*[sections addObject:@""];
        [items addObject:[NSArray arrayWithObject:[TTTableTextItem
                itemWithText:[[recipe rations] stringValue]]]];
        if ([[recipe ingredients] count] > 0) {
            NSMutableArray *subitems = [NSMutableArray array];

            [sections addObject:
                    NSLocalizedString(kRecipeDetailSectionIngredients, nil)];
            for (Ingredient *ingredient in [recipe ingredients]) {
                TTTableTextItem *item = [TTTableTextItem 
                        itemWithText: [ingredient formattedIngredientString]];

                [subitems addObject:item];
            }
            [items addObject:subitems];
        }
        if ([[recipe procedures] count] > 0) {
            NSMutableArray *subitems = [NSMutableArray array];

            [sections addObject:
                    NSLocalizedString(kRecipeDetailSectionProcedures, nil)];
            for (NSString *procedure in [recipe procedures]) {
                TTTableTextItem *item = [TTTableTextItem 
                        itemWithText: procedure];

                [subitems addObject:item];
            }
            [items addObject:subitems];
        }
        if ([[recipe tips] count] > 0) {
            NSMutableArray *subitems = [NSMutableArray array];

            [sections addObject:
                    NSLocalizedString(kRecipeDetailSectionTips, nil)];
            for (NSString *procedure in [recipe tips]) {
                TTTableTextItem *item = [TTTableTextItem 
                        itemWithText: procedure];

                [subitems addObject:item];
            }
            [items addObject:subitems];
        }
        if ([[[recipe strains] strains] count] > 0) {
            NSMutableArray *subitems = [NSMutableArray array];
            
            [sections addObject:
                    NSLocalizedString(kRecipeDetailSectionStrains, nil)];
            for (Strain *strain in [[recipe strains] strains]) {
                TTTableTextItem *item = [TTTableTextItem
                        itemWithText:[strain name]
                            URL:URL(kURLWineListCall, [strain strainId])];
                
                [subitems addObject:item];
            }
            [items addObject:subitems];
        }*/
        TTTableTextItem *ingredients = [TTTableTextItem
                itemWithText:kRecipeDetailSectionIngredients URL:nil];
        
        [items addObjectsFromArray:[NSArray arrayWithObjects:ingredients, nil]];
    }
    //[self setSections:sections];
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
