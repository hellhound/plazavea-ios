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
        NSMutableArray *sections = [NSMutableArray array];
        
        [sections addObject:kFoodDetailHeader];
        TableCaptionItem *calories = [TableCaptionItem itemWithText:
                [food calories] caption:kFoodDetailCalories];
        TableCaptionItem *carbohidrates = [TableCaptionItem itemWithText:
                [food carbohidrates] caption:kFoodDetailCarbohidrates];
        TableCaptionItem *fat = [TableCaptionItem itemWithText:
                [food fat] caption:kFoodDetailFat];
        TableCaptionItem *proteins = [TableCaptionItem itemWithText:
                [food proteins] caption:kFoodDetailProteins];
        TableCaptionItem *vitaminA = [TableCaptionItem itemWithText:
                [food vitaminA] caption:kFoodDetailVitaminA];
        TableCaptionItem *vitaminC = [TableCaptionItem itemWithText:
                [food vitaminC] caption:kFoodDetailVitaminC];
        [items addObject:[NSArray arrayWithObjects:calories, carbohidrates, fat,
                proteins, vitaminA, vitaminC, nil]];
        [self setSections:sections];
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