#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Composition/Constants.h"

NSString *const kFoodCategoryTitle = @"Composición";
// NSLocalizedString(@"Composición", nil)

// FoodCategory model's constants
NSString *const kFoodCategoryEntity = @"FoodCategory";
NSString *const kFoodCategoryClass = @"FoodCategory";
NSString *const kFoodCategoryName = @"name";
NSString *const kFoodCategoryFoods = @"foods";
NSString *const kFoodCategoryHeader = @"Composición Nutricional";
// NSLocalizedString(@"Composición Nutricional", nil)

NSString *const kFoodTitle = @"Alimentos";
// NSLocalizedString(@"Alimentos", nil)

// Food model's constants
NSString *const kFoodEntity = @"Food";
NSString *const kFoodClass = @"Food";
NSString *const kFoodInitial = @"Initial";
NSString *const kFoodName = @"name";
NSString *const kFoodCalories = @"calories";
NSString *const kFoodCarbohidrates = @"carbohidrates";
NSString *const kFoodFat = @"fat";
NSString *const kFoodProteins = @"proteins";
NSString *const kFoodVitaminA = @"vitaminA";
NSString *const kFoodVitaminC = @"vitaminC";
NSString *const kFoodCategory = @"category";

// FoodFile model's constants
NSString *const kFoodFileName = @"name";
NSString *const kFoodCSVFile = @"food.csv";

// FoodDetailController's constants

// messages
NSString *const kFoodDetailHeader = @"Composición";
// NSLocalizedString(@"Composición", nil)
NSString *const kFoodDetailCalories = @"Calorías";
// NSLocalizedString(@"Calorías", nil)
NSString *const kFoodDetailCarbohidrates = @"Carbohidratos disponibles";
// NSLocalizedString(@"Carbohidratos disponibles", nil)
NSString *const kFoodDetailFat = @"Grasas";
// NSLocalizedString(@"Grasas", nil)
NSString *const kFoodDetailProteins = @"Proteínas";
// NSLocalizedString(@"Proteínas", nil)
NSString *const kFoodDetailVitaminA = @"Vitamina A";
// NSLocalizedString(@"Vitamina A", nil)
NSString *const kFoodDetailVitaminC = @"Vitamina C";
// NSLocalizedString(@"Vitamina C", nil)
NSString *const kFoodDetailTitle = @"";
// NSLocalizedString(@"", nil)

NSString *const kFoodDetailDefaultImage = @"bundle://default-food-detail.png";
const CGFloat kFoodDetailImageWidth = 140.;
const CGFloat kFoodDetailImageHeight = 140.;

// Controller URLs
NSString *const kURLFoodCategory = @"tt://launcher/foodcategory/";
NSString *const kURLFoodDetail = @"tt://launcher/foodcategory/fooddetail/";