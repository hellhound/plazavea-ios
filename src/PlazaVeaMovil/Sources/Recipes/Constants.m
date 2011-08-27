#import <Foundation/Foundation.h>

#import "Common/Constants.h"
#import "Recipes/Constants.h"

// Recipe collection's constants
NSString *const kRecipeCollectionLettersKey = @"letters";
NSString *const kRecipeCollectionLetterKey = @"letter";
NSString *const kRecipeCollectionRecipesKey = @"recipes";

// Recipe model's constants

// JSON keys
NSString *const kRecipeIdKey = @"id";
NSString *const kRecipeCodeKey = @"code";
NSString *const kRecipeNameKey = @"name";
NSString *const kRecipePictureURLKey = @"picture";
NSString *const kRecipeExtraPictureURLsKey = @"extra_pictures";
NSString *const kRecipePriceKey = @"price";
NSString *const kRecipeIngredientsKey = @"ingredients";
NSString *const kRecipeProceduresKey = @"ingredients";
NSString *const kRecipeFeaturesKey = @"features";
NSString *const kRecipeRatinsKey = @"rations";
NSString *const kRecipeFacebookURLKey = @"facebook_url";
NSString *const kRecipeTwitterURLKey = @"twitter_url";

// Ingredient model's constants

// JSON keys
NSString *const kIngredientQuantityKey = @"quantity";
NSString *const kIngredientDescriptionKey = @"product";
NSString *const kIngredientCommentKey = @"comment";

// Messages

// AlphabeticalRecipesDataSource
NSString *kRecipesTitleForLoading = @"Obteniendo lista de recetas";
// NSLocalizedString(@"Obteniendo lista de recetas", nil)
NSString *kRecipesTitleForReloading = @"Actualizando lista de recetas";
// NSLocalizedString(@"Actualizando lista de recetas", nil)
NSString *kRecipesTitleForEmpty = @"No hay recetas";
// NSLocalizedString(@"No existen recetas aún", nil)
NSString *kRecipesSubtitleForEmpty = @"Por favor intente de nuevo más tarde, "
        @"aún no existen recetas disponibles";
// NSLocalizedString(@"por favor intente de nuevo más tarde, aún no existen "
//      @"recetas disponibles", nil)
NSString *kRecipesTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *kRecipesSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)

// RecipeController's constants

NSString *const kRecipesTitle = @"Recetas";

// Controllers URLs
NSString *const kURLRecipes = @"tt://launcher/recipes/";

// Controller URL's calls
NSString *const kURLRecipesCall = @"tt://launcher/recipes/";

// Endpoint URLs

NSString *const kURLRecipeAlphabeticEndpoint =
        ENDPOINT(@"/recipes/alphabetic.json");
NSString *const kURLRecipeDetailEndpoint = ENDPOINT(@"/recipes/details.json");