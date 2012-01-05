#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Constants.h"
#import "Recipes/Constants.h"

// Meat model's constants

NSString *const kMeatIdKey = @"id";
NSString *const kMeatNameKey = @"name";
NSString *const kMeatPictureURLKey = @"picture";
NSString *const kMeatsKey = @"meats";

// Recipe category collection's constants
NSString *const kRecipeCategoryCollectionCategoriesKey = @"categories";

// Recipe category's constants
NSString *const kRecipeCategoryIdKey = @"id";
NSString *const kRecipeCategoryNameKey = @"name";
NSString *const kRecipeCategoryCountKey = @"recipes";
NSString *const kRecipeSubcategoriesCountKey = @"subcategories";

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
NSString *const kRecipeProceduresKey = @"preparation";
NSString *const kRecipeFeaturesKey = @"features";
NSString *const kRecipeTipsKey = @"tips";
NSString *const kRecipeRationsKey = @"rations";
NSString *const kRecipeStrainsKey = @"categories";

// Ingredient model's constants

// JSON keys
NSString *const kIngredientQuantityKey = @"quantity";
NSString *const kIngredientNameKey = @"product";
NSString *const kIngredientCommentKey = @"comment";

// RecipeCategoryDataSource's messages

// AlphabeticalRecipesDataSource
NSString *const kRecipeCategoryTitleForLoading = @"Obteniendo categorías";
// NSLocalizedString(@"Obteniendo categorías", nil)
NSString *const kRecipeCategoryTitleForReloading = @"Actualizando categorías";
// NSLocalizedString(@"Actualizando categorías", nil)
NSString *const kRecipeCategoryTitleForEmpty = @"No hay categorías";
// NSLocalizedString(@"No hay categorías", nil)
NSString *const kRecipeCategorySubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existen categorías disponibles";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existen "
//      @"categorías disponibles", nil)
NSString *const kRecipeCategoryTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kRecipeCategorySubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)

// AlphabeticalRecipesDataSource's messages

// AlphabeticalRecipesDataSource
NSString *const kRecipeListTitleForLoading = @"Obteniendo lista de recetas";
// NSLocalizedString(@"Obteniendo lista de recetas", nil)
NSString *const kRecipeListTitleForReloading = @"Actualizando lista de recetas";
// NSLocalizedString(@"Actualizando lista de recetas", nil)
NSString *const kRecipeListTitleForEmpty = @"No hay recetas";
// NSLocalizedString(@"No recetas", nil)
NSString *const kRecipeListSubtitleForEmpty = @"Por favor intente de nuevo más "
        @"tarde, aún no existen recetas disponibles";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existen "
//      @"recetas disponibles", nil)
NSString *const kRecipeListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kRecipeListSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)

// MeatListDataSource's constants

NSString *const kMeatsListTitleForLoading = @"Obteniendo tipos de carnes";
// NSLocalizedString(@"Obteniendo tipos de carnes", nil)
NSString *const kMeatsListTitleForReloading = @"Actualizando tipos de carnes";
// NSLocalizedString(@"Actualizando tipos de carnes", nil)
NSString *const kMeatsListTitleForEmpty = @"No hay tipos de carnes";
// NSLocalizedString(@"No hay tipos de carnes", nil)
NSString *const kMeatsListSubtitleForEmpty = @"Por favor intente de nuevo más "
        @"tarde, aún no existen tipos de carnes disponibles";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existen "
//      @"tipos de carnes disponibles", nil)
NSString *const kMeatsListTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kMeatsListSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
const CGFloat kMeatsListImageWidth = 41.;
const CGFloat kMeatsListImageHeight = 41.;
NSString *const kChickenIcon = @"bundle://chicken-icon.png";
NSString *const kFishIcon = @"bundle://fish-icon.png";
NSString *const kMeatIcon = @"bundle://meat-icon.png";
NSString *const kPorkIcon = @"bundle://pork-icon.png";
NSString *const kOtherMeatsIcon = @"bundle://other-meats-icon.png";

// RecipeDetailDataSource's messages

NSString *const kRecipeDetailTitleForLoading = @"Obteniendo la receta";
// NSLocalizedString(@"Obteniendo la receta", nil)
NSString *const kRecipeDetailTitleForReloading = @"Actualizando la receta";
// NSLocalizedString(@"Actualizando la receta", nil)
NSString *const kRecipeDetailTitleForEmpty = @"Sin información";
// NSLocalizedString(@"Sin información", nil)
NSString *const kRecipeDetailSubtitleForEmpty = @"Por favor intente de nuevo "
        @"más tarde, aún no existe información para esta receta";
// NSLocalizedString(@"Por favor intente de nuevo más tarde, aún no existe "
//      @"información para esta receta", nil)
NSString *const kRecipeDetailTitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kRecipeDetailSubtitleForError = @"Error";
// NSLocalizedString(@"Error", nil)
NSString *const kRecipeDetailSectionFeatures = @"Características";
// NSLocalizedString(@"Características", nil)
NSString *const kRecipeDetailSectionIngredients = @"Ingredients";
// NSLocalizedString(@"Ingredients", nil)
NSString *const kRecipeDetailSectionProcedures = @"Preparación";
// NSLocalizedString(@"Preparación", nil)
NSString *const kRecipeDetailSectionTips = @"Tips";
// NSLocalizedString(@"Tips", nil)
NSString *const kRecipeDetailSectionStrains = @"Vinos recomendados";
// NSLocalizedString(@"Vinos recomendados", nil)

// RecipeDrillDownController's constants
NSString *const kRecipeDetailToListButtonTitle = @"Crear Lista";
// NSLocalizedString(@"Crear Lista", nil)

// UISegmentedControl's item for the toolbar: food button
NSString *const kRecipesFoodButton = @"Comidas";
// NSLocalizedString(@"Comidas", nil)
// UISegmentedControl's item for the toolbar: meat types button
NSString *const kRecipesMeatTypesButton = @"Tipos de carne";
// NSLocalizedString(@"Tipos de carne", nil)

// RecipeCategoryController's constants
NSString *const kRecipeCategoryTitle = @"Recetas";
// NSLocalizedString(@"Categorías", nil)
NSString *const kRecipeSubcategoryTitle = @"Subcategorías";
// NSLocalizedString(@"Subcategorías", nil)

// RecipeListController's constants

NSString *const kRecipeListTitle = @"Recetas";
// NSLocalizedString(@"Recetas", nil)
NSString *const kRecipeListDefaultImage = @"bundle://default-list.png";
const CGFloat kRecipeListImageWidth = 50.;
const CGFloat kRecipeListImageHeigth = 50.;

// RecipeDetailController's constants

NSString *const kRecipeDetailTitle = @"Detalle de una receta";
// NSLocalizedString(@"Detalle de una receta", nil);
NSString *const kRecipeRations = @"%@ personas";
// NSLocalizedString(@"%@ personas", nil);
NSString *const kRecipeDetailDefaultImage =
        @"bundle://default-recipe-detail.png";
const CGFloat kRecipeDetailImageWidth = 140.;
const CGFloat kRecipeDetailImageHeigth = 140.;
NSString *const kRecipeDetailCreateMessage = @"Lista %@ creada";
// NSLocalizedString(@"Lista %@ creada", nil)
NSString *const kRecipeDetailCreateButton = @"Ok";
// NSLocalizedString(@"Ok", nil)

// Controllers' URLs
NSString *const kURLMeats = @"tt://launcher/recipes/meats/";
NSString *const kURLRecipeCategories = @"tt://launcher/recipes/categories/";
NSString *const kURLRecipeSubcategories =
        @"tt://launcher/recipes/categories/subcategory/(initWithCategoryId:)/";
NSString *const kURLRecipeList =
        @"tt://launcher/recipes/category/(initWithCategoryId:)/";
NSString *const kURLRecipeMeatList =
        @"tt://launcher/recipes/meat/(initWithMeatId:)/";
NSString *const kURLRecipeDetail = @"tt://launcher/recipe/(initWithRecipeId:)/";
NSString *const kURLRecipeMeatsDetail =
        @"tt://launcher/meats/recipe/(initWithRecipeId:)/(hasMeat:)/";

// Controllers' URL calls
NSString *const kURLMeatsCall = @"tt://launcher/recipes/meats/";
NSString *const kURLRecipeCategoriesCall = @"tt://launcher/recipes/categories/";
NSString *const kURLRecipeSubCategoriesCall =
        @"tt://launcher/recipes/categories/subcategory/%@/";
NSString *const kURLRecipeListCall =
        @"tt://launcher/recipes/category/%@/";
NSString *const kURLRecipeMeatListCall =
        @"tt://launcher/recipes/meat/%@/";
NSString *const kURLRecipeDetailCall = @"tt://launcher/recipe/%@/";
NSString *const kURLRecipeMeatsDetailCall =
        @"tt://launcher/meats/recipe/%@/%@/";

// Endpoint URLs

NSString *const kURLRecipeCategoriesEndpoint =
        ENDPOINT(@"/recipes/categories.json");
NSString *const kURLRecipeSubcategoryEndpoint =
        ENDPOINT(@"/recipes/categories.json?cat=%@");
NSString *const kURLRecipeAlphabeticEndpoint =
        ENDPOINT(@"/recipes/alphabetic.json?cat=%@");
NSString *const kURLRecipeDetailEndpoint =
        ENDPOINT(@"/recipes/%@/details.json");
NSString *const kURLRecipeMeatsEndpoint =
        ENDPOINT(@"/meats/listing.json");
NSString *const kURLRecipeAlphabeticMeatEndpoint =
        ENDPOINT(@"/meats/%@/recipes.json");
