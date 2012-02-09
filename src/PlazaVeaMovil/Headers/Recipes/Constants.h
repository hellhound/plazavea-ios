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
extern NSString *const kRecipeCategoryKey;
extern NSString *const kRecipePictureURLKey;
extern NSString *const kRecipeExtraPictureURLsKey;
extern NSString *const kRecipePriceKey;
extern NSString *const kRecipeIngredientsKey;
extern NSString *const kRecipeProceduresKey;
extern NSString *const kRecipeFeaturesKey;
extern NSString *const kRecipeTipsKey;
extern NSString *const kRecipeRationsKey;
extern NSString *const kRecipeStrainsKey;

// Ingredient model's constants

// JSON keys
extern NSString *const kIngredientQuantityKey;
extern NSString *const kIngredientNameKey;
extern NSString *const kIngredientCommentKey;


// MeatListDataSource's constants

extern NSString *const kMeatsListTitleForLoading;
extern NSString *const kMeatsListTitleForReloading;
extern NSString *const kMeatsListTitleForEmpty;
extern NSString *const kMeatsListSubtitleForEmpty;
extern NSString *const kMeatsListTitleForError;
extern NSString *const kMeatsListSubtitleForError;
extern const CGFloat kMeatsListImageWidth;
extern const CGFloat kMeatsListImageHeight;
extern NSString *const kChickenIcon;
extern NSString *const kFishIcon;
extern NSString *const kMeatIcon;
extern NSString *const kPorkIcon;
extern NSString *const kOtherMeatsIcon;

// RecipeCategoryDataSource's messages

extern NSString *const kRecipeCategoryTitleForLoading;
extern NSString *const kRecipeCategoryTitleForReloading;
extern NSString *const kRecipeCategoryTitleForEmpty;
extern NSString *const kRecipeCategorySubtitleForEmpty;
extern NSString *const kRecipeCategoryTitleForError;
extern NSString *const kRecipeCategorySubtitleForError;

// AlphabeticalRecipesDataSource's messages

extern NSString *const kRecipeListTitleForLoading;
extern NSString *const kRecipeListTitleForReloading;
extern NSString *const kRecipeListTitleForEmpty;
extern NSString *const kRecipeListSubtitleForEmpty;
extern NSString *const kRecipeListTitleForError;
extern NSString *const kRecipeListSubtitleForError;

// RecipeDetailDataSource's messages

extern NSString *const kRecipeDetailTitleForLoading;
extern NSString *const kRecipeDetailTitleForReloading;
extern NSString *const kRecipeDetailTitleForEmpty;
extern NSString *const kRecipeDetailSubtitleForEmpty;
extern NSString *const kRecipeDetailTitleForError;
extern NSString *const kRecipeDetailSubtitleForError;
extern NSString *const kRecipeDetailSectionFeatures;
extern NSString *const kRecipeDetailSectionIngredients;
extern NSString *const kRecipeDetailSectionProcedures;
extern NSString *const kRecipeDetailSectionTips;
extern NSString *const kRecipeDetailSectionStrains;

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
extern NSString *const kRecipeCategoryImage;

// RecipeListController's constants

extern NSString *const kRecipeListTitle;
extern NSString *const kRecipeListDefaultImage;
extern const CGFloat kRecipeListImageWidth;
extern const CGFloat kRecipeListImageHeigth;

// RecipeDetailController's constants

extern NSString *const kRecipeDetailTitle;
extern NSString *const kRecipeRations;
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
extern NSString *const kURLIngredientRecipeDetail;
extern NSString *const kURLProceduresRecipeDetail;
extern NSString *const kURLTipsRecipeDetail;
extern NSString *const kURLIngredientRecipeMeatsDetail;
extern NSString *const kURLProceduresRecipeMeatsDetail;
extern NSString *const kURLTipsRecipeMeatsDetail;
extern NSString *const kURLRecipeStrainList;

// Controllers' URL calls
extern NSString *const kURLMeatsCall;
extern NSString *const kURLRecipeCategoriesCall;
extern NSString *const kURLRecipeSubCategoriesCall;
extern NSString *const kURLRecipeListCall;
extern NSString *const kURLRecipeMeatListCall;
extern NSString *const kURLRecipeDetailCall;
extern NSString *const kURLRecipeMeatsDetailCall;
extern NSString *const kURLIngredientRecipeDetailCall;
extern NSString *const kURLProceduresRecipeDetailCall;
extern NSString *const kURLTipsRecipeDetailCall;
extern NSString *const kURLIngredientRecipeMeatsDetailCall;
extern NSString *const kURLProceduresRecipeMeatsDetailCall;
extern NSString *const kURLTipsRecipeMeatsDetailCall;
extern NSString *const kURLRecipeStrainListCall;

// Endpoint URLs

extern NSString *const kURLRecipeCategoriesEndpoint;
extern NSString *const kURLRecipeSubcategoryEndpoint;
extern NSString *const kURLRecipeAlphabeticEndpoint;
extern NSString *const kURLRecipeDetailEndpoint;
extern NSString *const kURLRecipeMeatsEndpoint;
extern NSString *const kURLRecipeAlphabeticMeatEndpoint;