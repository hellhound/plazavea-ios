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
NSString *const kFoodInitial = @"initial";
NSString *const kFoodName = @"name";
NSString *const kFoodCalories = @"calories";
NSString *const kFoodCarbohidrates = @"carbohidrates";
NSString *const kFoodFat = @"fat";
NSString *const kFoodProteins = @"proteins";
NSString *const kFoodVitaminA = @"vitaminA";
NSString *const kFoodVitaminC = @"vitaminC";
NSString *const kFoodCategory = @"category";
NSString *const kFoodProperties = @"properties";
NSString *const kFoodQuantity = @"quantity";
NSString *const kFoodFiber = @"fiber";
NSString *const kFoodCalcium = @"calcium";
NSString *const kFoodIron = @"iron";

// FoodFile model's constants
NSString *const kFoodFileName = @"name";
NSString *const kFoodCSVFile = @"food.csv";

// FoodDetailController's constants

// messages
NSString *const kFoodDetailHeader = @"Composición";
// NSLocalizedString(@"Composición", nil)
NSString *const kFoodDetailCalories = @"Energía";
// NSLocalizedString(@"Energía", nil)
NSString *const kFoodDetailCarbohidrates = @"Carbohidratos";
// NSLocalizedString(@"Carbohidratos", nil)
NSString *const kFoodDetailFat = @"Grasas";
// NSLocalizedString(@"Grasas", nil)
NSString *const kFoodDetailProteins = @"Proteínas";
// NSLocalizedString(@"Proteínas", nil)
NSString *const kFoodDetailVitaminA = @"Vitamina A";
// NSLocalizedString(@"Vitamina A", nil)
NSString *const kFoodDetailVitaminC = @"Vitamina C";
// NSLocalizedString(@"Vitamina C", nil)
NSString *const kFoodDetailQuantity = @"Cantidad por ración";
// NSLocalizedString(@"Cantidad por ración", nil)
NSString *const kFoodDetailFiber = @"Fibra dietaria";
// NSLocalizedString(@"Fibra dietaria", nil)
NSString *const kFoodDetailCalcium = @"Calcio";
// NSLocalizedString(@"Calcio", nil)
NSString *const kFoodDetailIron = @"Hierro";
// NSLocalizedString(@"Hierro", nil)
NSString *const kFoodDetailTitle = @"";
// NSLocalizedString(@"", nil)
NSString *const kFoodDetailCaloriesSufix = @"%@ kcal";
// NSLocalizedString(@"%@ kcal", nil)
NSString *const kFoodDetailCarbohidratesSufix = @"%@ g";
// NSLocalizedString(@"%@ g", nil)
NSString *const kFoodDetailFatSufix = @"%@ g";
// NSLocalizedString(@"%@ g", nil)
NSString *const kFoodDetailProteinsSufix = @"%@ g";
// NSLocalizedString(@"%@ g", nil)
NSString *const kFoodDetailVitaminASufix = @"%@ µg";
// NSLocalizedString(@"%@ µg", nil)
NSString *const kFoodDetailVitaminCSufix = @"%@ mg";
// NSLocalizedString(@"%@ mg", nil)
NSString *const kFoodDetailQuantitySufix = @"%@ g";
// NSLocalizedString(@"%@ g", nil)
NSString *const kFoodDetailFiberSufix = @"%@ g";
// NSLocalizedString(@"%@ g", nil)
NSString *const kFoodDetailCalciumSufix = @"%@ mg";
// NSLocalizedString(@"%@ mg", nil)
NSString *const kFoodDetailIronSufix = @"%@ mg";
// NSLocalizedString(@"%@ mg", nil)
NSString *const kFoodDetailDefaultImage = @"bundle://default-food-detail.png";
const CGFloat kFoodDetailImageWidth = 140.;
const CGFloat kFoodDetailImageHeight = 140.;

// Controller URLs
NSString *const kURLFoodCategory = @"tt://launcher/foodcategory/";
NSString *const kURLFoodDetail = @"tt://launcher/foodcategory/fooddetail/";