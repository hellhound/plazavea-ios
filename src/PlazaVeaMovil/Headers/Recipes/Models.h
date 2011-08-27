#import <Foundation/Foundation.h>

#import "Common/Models/URLRequestModel.h"

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
@property (nonatomic, retain) NSNumber *rations;
@property (nonatomic, retain) NSURL *facebookURL;
@property (nonatomic, retain) NSURL *twitterURL;

+ (id)shortRecipeFromDictionary:(NSDictionary *)rawRecipe;
+ (id)recipeFromDictionary:(NSDictionary *)rawRecipe;
@end

@interface RecipeCollection: URLRequestModel
{
    NSMutableArray *_sections;
    NSMutableArray *_sectionTitles;
}
@property (nonatomic, readonly) NSArray *sections;
@property (nonatomic, readonly) NSArray *sectionIndexTitles;
@property (nonatomic, readonly) NSArray *sectionTitles;
@end
