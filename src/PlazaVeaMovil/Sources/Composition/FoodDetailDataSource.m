#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableCaptionItem.h"
#import "Common/Views/TableCaptionItemCell.h"

#import "Composition/Models.h"
#import "Composition/Constants.h"
#import "Composition/FoodDetailDataSource.h"

@implementation FoodDetailDataSource

#pragma mark -
#pragma mark StoreDetailDataSource (public)

- (id)  initWithFood:(Food *)food
{
    if ((self = [super init]) != nil) {        
        NSMutableArray *items = [NSMutableArray array];
        
        if ([[food calories] length] > 0) {
            TableCaptionItem *calories = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailCaloriesSufix,
                        [food calories]] caption:kFoodDetailCalories];
            [items addObject:calories];
        }
        if ([[food carbohidrates] length] > 0) {
            TableCaptionItem *carbohidrates = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailCarbohidratesSufix,
                        [food carbohidrates]] caption:kFoodDetailCarbohidrates];
            [items addObject:carbohidrates];
        }
        if ([[food fat] length] > 0) {
            TableCaptionItem *fat = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailFatSufix,
                        [food fat]] caption:kFoodDetailFat];
            [items addObject:fat];
        }
        if ([[food proteins] length] > 0) {
            TableCaptionItem *proteins = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailProteinsSufix,
                        [food proteins]] caption:kFoodDetailProteins];
            [items addObject:proteins];
        }
        if ([[food vitaminA] length] > 0) {
            TableCaptionItem *vitaminA = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailVitaminASufix,
                        [food vitaminA]] caption:kFoodDetailVitaminA];
            [items addObject:vitaminA];
        }
        if ([[food vitaminC] length] > 0) {
            TableCaptionItem *vitaminC = [TableCaptionItem itemWithText:
                    [NSString stringWithFormat:kFoodDetailVitaminCSufix,
                        [food vitaminC]] caption:kFoodDetailVitaminC];
            [items addObject:vitaminC];
        }
        [self setItems:items];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    if ([object isKindOfClass:[TableCaptionItem class]])
        return [TableCaptionItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end