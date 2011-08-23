#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"

// Recipe's key pathes
static NSString *const kMutableExtraPictureURLsKey = @"extraPictureURLs";
static NSString *const kMutableIngredientsKey = @"ingredients";
static NSString *const kMutableProceduresKey = @"procedures";
static NSString *const kMutableFeaturesKey = @"features";
// Recipe collection's key pathes
static NSString *const kMutbaleRecipesKey = @"recipes";

@implementation Ingredient

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_quantity release];
    [_description release];
    [_comment release];
    [super dealloc];
}

#pragma mark -
#pragma mark Ingredient (Public)

@synthesize quantity = _quantity, description = _description,
    comment = _comment;

+ (id)ingredientFromDictionary:(NSDictionary *)rawIngredient
{
    NSString *quantity, *description, *comment;

    if (![rawIngredient isKindOfClass:[NSDictionary class]])
        return nil;
    if ((quantity = [rawIngredient objectForKey:kIngredientQuantityKey]) != nil)
        return nil;
    if (![quantity isKindOfClass:[NSString class]])
        return nil;
    if ((description =
            [rawIngredient objectForKey:kIngredientDescriptionKey]) != nil)
        return nil;
    if (![description isKindOfClass:[NSString class]])
        return nil;
    if ((comment = [rawIngredient objectForKey:kIngredientCommentKey]) != nil)
        return nil;
    if (![comment isKindOfClass:[NSString class]])
        return nil;

    Ingredient *ingredient = [[[Ingredient alloc] init] autorelease];

    [ingredient setQuantity:quantity];
    [ingredient setDescription:description];
    [ingredient setComment:comment];
    return ingredient;
}
@end

@implementation Recipe

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_recipeId release];
    [_code release];
    [_name release];
    [_pictureURL release];
    [_extraPictureURLs release];
    [_price release];
    [_ingredients release];
    [_procedures release];
    [_features release];
    [_rations release];
    [_facebookURL release];
    [_twitterURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

// KVC compliance for indexed to-many collections
@synthesize extraPictureURLs = _extraPictureURLs, ingredients = _ingredients,
    procedures = _procedures, features = _features;

- (void)        insertObject:(NSURL *)extraURL
   inExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPictureURLs insertObject:extraURL atIndex:index];
}

- (void)insertExtraPictureURLs:(NSArray *)extraURLs
                     atIndexes:(NSIndexSet *)indexes
{
    [_extraPictureURLs insertObjects:extraURLs atIndexes:indexes];
}

- (void)removeObjectFromExtraPictureURLsAtIndex:(NSUInteger)index
{
    [_extraPictureURLs removeObjectAtIndex:index];
}

- (void)removeExtraPictureURLsAtIndexes:(NSIndexSet *)indexes
{
    [_extraPictureURLs removeObjectsAtIndexes:indexes];
}

- (void)    insertObject:(Ingredient *)ingredient
    inIngredientsAtIndex:(NSUInteger)index
{
    [_ingredients insertObject:ingredient atIndex:index];
}

- (void)insertIngredients:(NSArray *)ingredients atIndexes:(NSIndexSet *)indexes
{
    [_ingredients insertObjects:ingredients atIndexes:indexes];
}

- (void)removeObjectFromIngredientsAtIndex:(NSUInteger)index
{
    [_ingredients removeObjectAtIndex:index];
}

- (void)removeIngredientsAtIndexes:(NSIndexSet *)indexes
{
    [_ingredients removeObjectsAtIndexes:indexes];
}

- (void)insertObject:(NSString *)procedure inProceduresAtIndex:(NSUInteger)index
{
    [_procedures insertObject:procedure atIndex:index];
}

- (void)insertProcedures:(NSArray *)procedures atIndexes:(NSIndexSet *)indexes
{
    [_procedures insertObjects:procedures atIndexes:indexes];
}

- (void)removeObjectFromProceduresAtIndex:(NSUInteger)index
{
    [_procedures removeObjectAtIndex:index];
}

- (void)removeProceduresAtIndexes:(NSIndexSet *)indexes
{
    [_procedures removeObjectsAtIndexes:indexes];
}

- (void)insertObject:(NSString *)feature inFeaturesAtIndex:(NSUInteger)index
{
    [_features insertObject:feature atIndex:index];
}

- (void)insertFeatures:(NSArray *)features atIndexes:(NSIndexSet *)indexes
{
    [_features insertObjects:features atIndexes:indexes];
}

- (void)removeObjectFromFeaturesAtIndex:(NSUInteger)index
{
    [_features removeObjectAtIndex:index];
}

- (void)removeFeaturesAtIndexes:(NSIndexSet *)indexes
{
    [_features removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark Recipe (Public)

@synthesize recipeId = _recipeId, code = _code, name = _name,
    pictureURL = _pictureURL, price = _price, rations = _rations,
    facebookURL = _facebookURL, twitterURL = _twitterURL;

+ (id)shortRecipeFromDictionary:(NSDictionary *)rawRecipe
{
    NSNumber *recipeId;
    NSString *name;

    if (![rawRecipe isKindOfClass:[NSDictionary class]])
        return nil;
    if ((recipeId = [rawRecipe objectForKey:kRecipeIdKey]) != nil)
        return nil;
    if (![recipeId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawRecipe objectForKey:kRecipeNameKey]) != nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;

    Recipe *recipe = [[[Recipe alloc] init] autorelease];

    [recipe setRecipeId:recipeId];
    [recipe setName:name];
    return recipe;
}

+ (id)recipeFromDictionary:(NSDictionary *)rawRecipe
{
    Recipe *recipe = [self shortRecipeFromDictionary:rawRecipe];

    if (recipe == nil)
        return nil;

    NSString *code, *pictureURL, *facebookURL, *twitterURL;
    NSNumber *price, *rations;
    NSArray *extraPictureURLs, *ingredients, *procedures, *features;
    NSMutableArray *mutableExtraPictureURLs =
            [recipe mutableArrayValueForKey:kMutableExtraPictureURLsKey]; 
    NSMutableArray *mutableIngredients =
            [recipe mutableArrayValueForKey:kMutableIngredientsKey]; 
    NSMutableArray *mutableProcedures =
            [recipe mutableArrayValueForKey:kMutableProceduresKey]; 
    NSMutableArray *mutableFeatures =
            [recipe mutableArrayValueForKey:kMutableFeaturesKey]; 

    if ((code = [rawRecipe objectForKey:kRecipeCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawRecipe objectForKey:kRecipePictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]])
        return nil;
    if ((extraPictureURLs =
            [rawRecipe objectForKey:kRecipeExtraPictureURLsKey]) == nil)
        return nil;
    if ((price = [rawRecipe objectForKey:kRecipePriceKey]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]])
        return nil;
    if ((ingredients = [rawRecipe objectForKey:kRecipeIngredientsKey]) == nil)
        return nil;
    if (![ingredients isKindOfClass:[NSArray class]])
        return nil;
    if ((procedures = [rawRecipe objectForKey:kRecipeProceduresKey]) == nil)
        return nil;
    if (![procedures isKindOfClass:[NSArray class]])
        return nil;
    if ((features = [rawRecipe objectForKey:kRecipeFeaturesKey]) == nil)
        return nil;
    if (![features isKindOfClass:[NSArray class]])
        return nil;
    if ((rations = [rawRecipe objectForKey:kRecipeRatinsKey]) == nil)
        return nil;
    if (![rations isKindOfClass:[NSNumber class]])
        return nil;
    if ((facebookURL = [rawRecipe objectForKey:kRecipeFeaturesKey]) == nil)
        return nil;
    if (![facebookURL isKindOfClass:[NSString class]])
        return nil;
    if ((twitterURL = [rawRecipe objectForKey:kRecipeFeaturesKey]) == nil)
        return nil;
    if (![twitterURL isKindOfClass:[NSString class]])
        return nil;
    [recipe setCode:code];
    [recipe setPictureURL:[NSURL URLWithString:pictureURL]];
    [recipe setPrice:price];
    [recipe setRations:rations];
    [recipe setFacebookURL:[NSURL URLWithString:facebookURL]];
    [recipe setTwitterURL:[NSURL URLWithString:twitterURL]];
    [mutableExtraPictureURLs addObjectsFromArray:extraPictureURLs];
    [mutableProcedures addObjectsFromArray:procedures];
    [mutableFeatures addObjectsFromArray:features];
    for (NSDictionary *rawIngredient in ingredients) {
        Ingredient *ingredient =
                [Ingredient ingredientFromDictionary:rawIngredient];

        if (ingredient == nil)
            // Quit!
            return nil;
        [mutableIngredients addObject:ingredient];
    }
    return recipe;
}
@end

@implementation RecipeCollection

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_recipes release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

- (void)insertObject:(Recipe *)recipe inRecipesAtIndex:(NSUInteger)index
{
    [_recipes insertObject:recipe atIndex:index];
}

- (void)insertRecipes:(NSArray *)recipes atIndexes:(NSIndexSet *)indexes
{
    [_recipes insertObjects:recipes atIndexes:indexes];
}

- (void)removeObjectFromRecipesAtIndex:(NSUInteger)index
{
    [_recipes removeObjectAtIndex:index];
}

- (void)removeRecipesAtIndexes:(NSIndexSet *)indexes
{
    [_recipes removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    TTURLRequest *request =
            [TTURLRequest requestWithURL:kURLRecipeAlphabeticEndpoint
                delegate:self];

    ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
    [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
    [request send];
}

#pragma mark -
#pragma mark <TTURLRequestCacheDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    NSArray *letters;
    NSMutableArray *mutableRecipes =
            [self mutableArrayValueForKey:kMutbaleRecipesKey];

    if (![rootObject isKindOfClass:[NSDictionary class]])
        return;
    if ((letters =
            [rootObject objectForKey:kRecipeCollectionLettersKey]) == nil)
        return;
    for (NSDictionary *recipeCluster in letters) {
        NSArray *rawRecipes;

        if (![recipeCluster isKindOfClass:[NSDictionary class]])
            // Quit!
            return;
        if ((rawRecipes = [recipeCluster objectForKey:
                kRecipeCollectionRecipesKey]) == nil)
            return;
        for (NSDictionary *rawRecipe in rawRecipes) {
            Recipe *recipe = [Recipe shortRecipeFromDictionary:rawRecipe];

            if (recipe == nil)
                // Quit!
                return;
            [mutableRecipes addObject:recipe];
        }
    }
    [super requestDidFinishLoad:request];
}

#pragma mark -
#pragma mark RecipeCollection (Public)

@synthesize recipes = _recipes;
@end
