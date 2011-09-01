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
NSString *const kRecipeTipsKey = @"tips";
NSString *const kRecipeRationsKey = @"rations";
NSString *const kRecipeFacebookURLKey = @"facebook_url";
NSString *const kRecipeTwitterURLKey = @"twitter_url";

// Ingredient model's constants

// JSON keys
NSString *const kIngredientQuantityKey = @"quantity";
NSString *const kIngredientDescriptionKey = @"product";
NSString *const kIngredientCommentKey = @"comment";

// AlphabeticalRecipesDataSource's messages

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

// RecipeDetailDataSource's messages

NSString *kRecipeDetailTitleForLoading = @"Obteniendo la receta";
// NSLocalizedString(@"Obteniendo la receta", nil)
NSString *kRecipeDetailTitleForReloading = @"Actualizando la receta";
// NSLocalizedString(@"Actualizando la receta", nil)
NSString *kRecipeDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"Sin información", nil)
NSString *kRecipeDetailSubtitleForEmpty = @"Por favor intente de nuevo más "
        @"tarde, aún no existe información para esta receta";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existe "
//      @"información para esta receta", nil)
NSString *kRecipeDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *kRecipeDetailSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)

// RecipesController's constants

NSString *const kRecipesTitle = @"Recetas";
// NSLocalizedString(@"Recetas", nil)
// UISegmentedControl's item for the toolbar: food button
NSString *const kRecipesFoodButton = @"Comidas";
// NSLocalizedString(@"Comidas", nil)
// UISegmentedControl's item for the toolbar: meat types button
NSString *const kRecipesMeatTypesButton = @"Tipos de carne";
// NSLocalizedString(@"Tipos de carne", nil)

// RecipeDetailController's constants

NSString *const kRecipeDetailTitle = @"Detalle de una receta";
// NSLocalizedString(@"Detalle de una receta", nil);

// Controllers' URLs
NSString *const kURLRecipes = @"tt://launcher/recipes/";
NSString *const kURLRecipeDetail = @"tt://launcher/recipe/(initWithRecipeId:)/";

// Controllers' URL calls
NSString *const kURLRecipesCall = @"tt://launcher/recipes/";
NSString *const kURLRecipeDetailCall = @"tt://launcher/recipe/%@/";

// Endpoint URLs

NSString *const kURLRecipeAlphabeticEndpoint =
        ENDPOINT(@"/recipes/alphabetic.json");
NSString *const kURLRecipeDetailEndpoint =
        ENDPOINT(@"/recipes/%@/details.json");
