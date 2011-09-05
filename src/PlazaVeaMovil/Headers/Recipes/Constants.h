// Recipes module's constants
#import <Foundation/Foundation.h>

// Recipe category collection's constants
extern NSString *const kRecipeCategoryCollectionCategoriesKey;

// Recipe category's constants
extern NSString *const kRecipeCategoryIdKey;
extern NSString *const kRecipeCategoryNameKey;
extern NSString *const kRecipeCategoryCountKey;

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
extern NSString *const kRecipeTipsKey;
extern NSString *const kRecipeRationsKey;
extern NSString *const kRecipeFacebookURLKey;
extern NSString *const kRecipeTwitterURLKey;

// Ingredient model's constants

// JSON keys
extern NSString *const kIngredientQuantityKey;
extern NSString *const kIngredientDescriptionKey;
extern NSString *const kIngredientCommentKey;

// RecipeCategoryDataSource's messages

extern NSString *kRecipeCategoryTitleForLoading;
extern NSString *kRecipeCategoryTitleForReloading;
extern NSString *kRecipeCategoryTitleForEmpty;
extern NSString *kRecipeCategorySubtitleForEmpty;
extern NSString *kRecipeCategoryTitleForError;
extern NSString *kRecipeCategorySubtitleForError;

// AlphabeticalRecipesDataSource's messages

extern NSString *kRecipeListTitleForLoading;
extern NSString *kRecipeListTitleForReloading;
extern NSString *kRecipeListTitleForEmpty;
extern NSString *kRecipeListSubtitleForEmpty;
extern NSString *kRecipeListTitleForError;
extern NSString *kRecipeListSubtitleForError;

// RecipeDetailDataSource's messages

extern NSString *kRecipeDetailTitleForLoading;
extern NSString *kRecipeDetailTitleForReloading;
extern NSString *kRecipeDetailTitleForEmpty;
extern NSString *kRecipeDetailSubtitleForEmpty;
extern NSString *kRecipeDetailTitleForError;
extern NSString *kRecipeDetailSubtitleForError;

// RecipeDrillDownController's constants

typedef enum {
    kRecipesSegmentedControlIndexDefault,
    kRecipesSegmentedControlIndexFoodButton =
        kRecipesSegmentedControlIndexDefault,
    kRecipesSegmentedControlIndexMeatTypesButton
} RecipesSegmentedControlIndexTypes;

// UISegmentedControl's item for the toolbar: food button
extern NSString *const kRecipesFoodButton;
// UISegmentedControl's item for the toolbar: meat types button
extern NSString *const kRecipesMeatTypesButton;

// RecipeCategoryController's constants
extern NSString *const kRecipeCategoryTitle;

// RecipeListController's constants

extern NSString *const kRecipeListTitle;

// RecipeDetailController's constants

extern NSString *const kRecipeDetailTitle;

// Controllers' URLs
extern NSString *const kURLRecipeCategories;
extern NSString *const kURLRecipeList;
extern NSString *const kURLRecipeDetail;

// Controllers' URL calls
extern NSString *const kURLRecipeCategoriesCall;
extern NSString *const kURLRecipeListCall;
extern NSString *const kURLRecipeDetailCall;

// Endpoint URLs

extern NSString *const kURLRecipeCategoriesEndpoint;
extern NSString *const kURLRecipeAlphabeticEndpoint;
extern NSString *const kURLRecipeDetailEndpoint;
