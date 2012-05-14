#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"
#import "Wines/Models.h"
#import "ShoppingList/Models.h"

@interface Meat: NSObject
{
    NSNumber *_meatId;
    NSString *_name;
}
@property (nonatomic, retain) NSNumber *meatId;
@property (nonatomic, copy) NSString *name;

+ (id)shortMeatFromDictionary:(NSDictionary *)rawMeat;
@end

@interface MeatCollection : URLRequestModel
{
    NSMutableArray *_meats;
}
@property (nonatomic, readonly) NSMutableArray *meats;
@end

@interface RecipeCategory: NSObject
{
    NSNumber *_categoryId;
    NSString *_name;
    NSNumber *_recipeCount;
    NSNumber *_subcategoriesCount;
}
@property (nonatomic, retain) NSNumber *categoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *recipeCount;
@property (nonatomic, retain) NSNumber *subcategoriesCount;

+ (id)shortRecipeCategoryFromDictionary:(NSDictionary *)rawRecipeCategory;
+ (id)recipeCategoryFromDictionary:(NSDictionary *)rawRecipeCategory;
@end

@interface RecipeCategoryCollection: URLRequestModel
{
    NSString *_categoryId;
    NSMutableArray *_categories;
}
@property (nonatomic, readonly) NSArray *categories;
@property (nonatomic, readonly) NSString *categoryId;

- (id)initWithCategoryId:(NSString *)categoryId;
@end

@interface Ingredient: NSObject
{
    NSString *_quantity;
    NSString *_name;
    NSString *_comment;
}
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *comment;

+ (id)ingredientFromDictionary:(NSDictionary *)rawIngredient;
- (NSString *)formattedIngredientString;
@end

@interface Contribution : NSObject
{
    NSNumber *_calories;
    NSNumber *_carbohydrates;
    NSNumber *_fats;
    NSNumber *_fiber;
    NSNumber *_proteins;
}
@property (nonatomic, copy) NSNumber *calories;
@property (nonatomic, copy) NSNumber *carbohydrates;
@property (nonatomic, copy) NSNumber *fats;
@property (nonatomic, copy) NSNumber *fiber;
@property (nonatomic, copy) NSNumber *proteins;

+ (id)contributionFromDictionary:(NSDictionary *)rawContribution;
@end

@interface Recipe: URLRequestModel
{
    NSNumber *_recipeId;
    NSString *_code;
    RecipeCategory *_category;
    NSString *_name;
    NSURL *_pictureURL;
    NSMutableArray *_extraPictureURLs;
    //NSNumber *_price;
    NSMutableArray *_ingredients;
    NSMutableArray *_procedures;
    NSMutableArray *_features;
    NSMutableArray *_tips;
    NSNumber *_rations;
    Contribution *_contribution;
    NSUInteger _didFinishCount;
    StrainCollection *_strains;
}
@property (nonatomic, retain) NSNumber *recipeId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, retain)RecipeCategory *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSURL *pictureURL;
@property (nonatomic, readonly) NSArray *extraPictureURLs;
//@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, readonly) NSArray *ingredients;
@property (nonatomic, readonly) NSArray *procedures;
@property (nonatomic, readonly) NSArray *features;
@property (nonatomic, readonly) NSArray *tips;
@property (nonatomic, retain) Contribution *contribution;
@property (nonatomic, retain) NSNumber *rations;
@property (nonatomic, retain) StrainCollection *strains;

+ (id)shortRecipeFromDictionary:(NSDictionary *)rawRecipe;
+ (id)recipeFromDictionary:(NSDictionary *)rawRecipe;

- (id)initWithRecipeId:(NSString *)recipeId;
- (void)copyPropertiesFromRecipe:(Recipe *)recipe;
- (BOOL)isColdMeal;
- (ShoppingList *)createShoppingList;
- (void)confirmFinishLoad;
@end

@interface RecipeCollection: URLRequestModel
{
    NSString *_collectionEndpointURL;
    NSString *_collectionId;
    NSMutableArray *_sections;
    NSMutableArray *_sectionTitles;
    kRecipeFromType _from;
}
@property (nonatomic, readonly) NSString *collectionId;
@property (nonatomic, readonly) NSArray *sections;
@property (nonatomic, readonly) NSArray *sectionIndexTitles;
@property (nonatomic, readonly) NSArray *sectionTitles;
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithMeatId:(NSString *)meatId;
- (id)initWithWineId:(NSString *)wineId;
- (NSArray *)sectionIndexTitles;
@end

@interface RecipeCollectionFromWine: URLRequestModel
{
    NSString *_collectionId;
    NSMutableArray *_sections;
}
@property (nonatomic, readonly) NSString *collectionId;
@property (nonatomic, readonly) NSArray *sections;

+ (id)recipeCollectionFromDictionary:(NSDictionary *)rawCollection;

- (id)initWithWineId:(NSString *)wineId;
- (void)copyPropertiesFromCollection:(RecipeCollectionFromWine *)collection;
@end