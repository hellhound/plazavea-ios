// Recipes module's constants
#import <Foundation/Foundation.h>

// Recipe collection's constants
extern NSString *const kRecipeCollectionLettersKey;
extern NSString *const kRecipeCollectionLetterKey;
extern NSString *const kRecipeCollectionRecipesKey;

// Recipe model's constants

// JSON keys
extern NSString *const kRecipeIdKey;
extern NSString *const kRecipeCodeKey;
extern NSString *const kRecipeNameKey;
extern NSString *const kRecipePictureURLKey;
extern NSString *const kRecipeExtraPictureURLsKey;
extern NSString *const kRecipePriceKey;
extern NSString *const kRecipeIngredientsKey;
extern NSString *const kRecipeProceduresKey;
extern NSString *const kRecipeFeaturesKey;
extern NSString *const kRecipeRatinsKey;
extern NSString *const kRecipeFacebookURLKey;
extern NSString *const kRecipeTwitterURLKey;

// Ingredient model's constants

// JSON keys
extern NSString *const kIngredientQuantityKey;
extern NSString *const kIngredientDescriptionKey;
extern NSString *const kIngredientCommentKey;

// Messages

extern NSString *kRecipesTitleForLoading;
extern NSString *kRecipesTitleForReloading;
extern NSString *kRecipesTitleForEmpty;
extern NSString *kRecipesSubtitleForEmpty;
extern NSString *kRecipesTitleForError;
extern NSString *kRecipesSubtitleForError;

// RecipeController's constants

typedef enum {
    kRecipesSegmentedControlIndexDefault,
    kRecipesSegmentedControlIndexFoodButton =
        kRecipesSegmentedControlIndexDefault,
    kRecipesSegmentedControlIndexMeatTypesButton
} RecipesSegmentedControlIndexTypes;

extern NSString *const kRecipesTitle;
// UISegmentedControl's item for the toolbar: food button
extern NSString *const kRecipesFoodButton;
// UISegmentedControl's item for the toolbar: meat types button
extern NSString *const kRecipesMeatTypesButton;

// Controllers URLs
extern NSString *const kURLRecipes;

// Controller URL's calls
extern NSString *const kURLRecipesCall;

// Endpoint URLs

extern NSString *const kURLRecipeAlphabeticEndpoint;
extern NSString *const kURLRecipeDetailEndpoint;
