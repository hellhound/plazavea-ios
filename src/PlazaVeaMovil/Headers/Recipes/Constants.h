// Recipes module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Meat model's constants
extern NSString *const kMeatIdKey;
extern NSString *const kMeatNameKey;
extern NSString *const kMeatPictureURLKey;
extern NSString *const kMeatsKey;

// Recipe category collection's constants
extern NSString *const kRecipeCategoryCollectionCategoriesKey;

// Recipe category's constants
extern NSString *const kRecipeCategoryIdKey;
extern NSString *const kRecipeCategoryNameKey;
extern NSString *const kRecipeCategoryCountKey;
extern NSString *const kRecipeSubcategoriesCountKey;

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
extern NSString *const kIngredientNameKey;
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
extern NSString *kRecipeDetailSectionFeatures;
extern NSString *kRecipeDetailSectionIngredients;
extern NSString *kRecipeDetailSectionProcedures;
extern NSString *kRecipeDetailSectionTips;

// RecipeDrillDownController's constants

typedef enum {
    kRecipesSegmentedControlIndexFoodButton,
    kRecipesSegmentedControlIndexMeatButton,
    kRecipesSegmentedControlIndexDefault =
        kRecipesSegmentedControlIndexFoodButton
} RecipesSegmentedControlIndexTypes;

extern NSString *const kRecipeDetailToListButtonTitle;

// UISegmentedControl's item for the toolbar: food button
extern NSString *const kRecipesFoodButton;
// UISegmentedControl's item for the toolbar: meat types button
extern NSString *const kRecipesMeatTypesButton;

// RecipeCategoryController's constants
extern NSString *const kRecipeCategoryTitle;
extern NSString *const kRecipeSubcategoryTitle;

// RecipeListController's constants

extern NSString *const kRecipeListTitle;

// RecipeDetailController's constants

extern NSString *const kRecipeDetailTitle;
extern NSString *const kRecipeDetailDefaultImage;
extern const CGFloat kRecipeDetailImageWidth;
extern const CGFloat kRecipeDetailImageHeigth;
extern NSString *const kRecipeDetailCreateMessage;
extern NSString *const kRecipeDetailCreateButton;

// Controllers' URLs
extern NSString *const kURLMeats;
extern NSString *const kURLRecipeCategories;
extern NSString *const kURLRecipeSubcategories;
extern NSString *const kURLRecipeList;
extern NSString *const kURLRecipeMeatList;
extern NSString *const kURLRecipeDetail;
extern NSString *const kURLRecipeMeatsDetail;

// Controllers' URL calls
extern NSString *const kURLMeatsCall;
extern NSString *const kURLRecipeCategoriesCall;
extern NSString *const kURLRecipeSubCategoriesCall;
extern NSString *const kURLRecipeListCall;
extern NSString *const kURLRecipeMeatListCall;
extern NSString *const kURLRecipeDetailCall;
extern NSString *const kURLRecipeMeatsDetailCall;

// Endpoint URLs

extern NSString *const kURLRecipeCategoriesEndpoint;
extern NSString *const kURLRecipeSubcategoryEndpoint;
extern NSString *const kURLRecipeAlphabeticEndpoint;
extern NSString *const kURLRecipeDetailEndpoint;
extern NSString *const kURLRecipeMeatsEndpoint;
extern NSString *const kURLRecipeAlphabeticMeatEndpoint;
