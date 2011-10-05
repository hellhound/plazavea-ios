#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

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
    NSString *_description;
    NSString *_comment;
}
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *comment;

+ (id)ingredientFromDictionary:(NSDictionary *)rawIngredient;
- (NSString *)formattedIngredientString;
@end

@interface Recipe: URLRequestModel
{
    NSNumber *_recipeId;
    NSString *_code;
    NSString *_name;
    NSURL *_pictureURL;
    NSMutableArray *_extraPictureURLs;
    NSNumber *_price;
    NSMutableArray *_ingredients;
    NSMutableArray *_procedures;
    NSMutableArray *_features;
    NSMutableArray *_tips;
    NSNumber *_rations;
    NSURL *_facebookURL;
    NSURL *_twitterURL;
}
@property (nonatomic, retain) NSNumber *recipeId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSURL *pictureURL;
@property (nonatomic, readonly) NSArray *extraPictureURLs;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, readonly) NSArray *ingredients;
@property (nonatomic, readonly) NSArray *procedures;
@property (nonatomic, readonly) NSArray *features;
@property (nonatomic, readonly) NSArray *tips;
@property (nonatomic, retain) NSNumber *rations;
@property (nonatomic, retain) NSURL *facebookURL;
@property (nonatomic, retain) NSURL *twitterURL;

+ (id)shortRecipeFromDictionary:(NSDictionary *)rawRecipe;
+ (id)recipeFromDictionary:(NSDictionary *)rawRecipe;

- (id)initWithRecipeId:(NSString *)recipeId;
- (void)copyPropertiesFromRecipe:(Recipe *)recipe;
@end

@interface RecipeCollection: URLRequestModel
{
    NSString *_categoryId;
    NSMutableArray *_sections;
    NSMutableArray *_sectionTitles;
}
@property (nonatomic, readonly) NSString *categoryId;
@property (nonatomic, readonly) NSArray *sections;
@property (nonatomic, readonly) NSArray *sectionIndexTitles;
@property (nonatomic, readonly) NSArray *sectionTitles;

- (id)initWithCategoryId:(NSString *)categoryId;
- (NSArray *)sectionIndexTitles;
@end
