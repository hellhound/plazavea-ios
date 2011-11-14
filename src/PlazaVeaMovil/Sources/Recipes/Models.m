#import <Foundation/Foundation.h>

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

#import "Common/Constants.h"
#import "Common/Additions/NSURL+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/Constants.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"

// Recipe category collection's key pathes
static NSString *const kMutableCategoriesKey = @"categories";
// Recipe collection's key pathes
static NSString *const kMutbaleSectionsKey = @"sections";
static NSString *const kMutableSectionTitlesKey = @"sectionTitles";
// Recipe's key pathes
static NSString *const kMutableExtraPictureURLsKey = @"extraPictureURLs";
static NSString *const kMutableIngredientsKey = @"ingredients";
static NSString *const kMutableProceduresKey = @"procedures";
static NSString *const kMutableFeaturesKey = @"features";
static NSString *const kMutableTipsKey = @"tips";
//Meat's key pathes
static NSString *const kMutableMeatsKey = @"meats";
// Recipe misc constants
static NSString *const kRecipeMiscYes = @"YES";

@implementation Meat

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_meatId release];
    [_name release];
    [_pictureURL release];
    [super dealloc];
}

#pragma mark -
#pragma mark Meat (Public)

@synthesize meatId = _meatId, name = _name, pictureURL = _pictureURL;

+ (id)shortMeatFromDictionary:(NSDictionary *)rawMeat
{
    NSNumber *meatId;
    NSString *name, *pictureURL;
    
    if (![rawMeat isKindOfClass:[NSDictionary class]])
        return nil;
    if ((meatId = [rawMeat objectForKey:kMeatIdKey]) == nil)
        return nil;
    if (![meatId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawMeat objectForKey:kMeatNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawMeat objectForKey:kMeatPictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }
    
    Meat *meat = [[[Meat alloc] init] autorelease];
    
    [meat setMeatId:meatId];
    [meat setName:name];
    if (pictureURL != nil)
        [meat setPictureURL:[NSURL URLWithString:pictureURL]];
    return meat;
}
@end

@implementation MeatCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _meats = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_meats release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

@synthesize meats = _meats;

- (void)insertObject:(NSURL *)meat inMeatsAtIndex:(NSUInteger)index
{
    [_meats insertObject:meat atIndex:index];
}

- (void)insertMeats:(NSArray *)meats atIndexes:(NSIndexSet *)indexes
{
    [_meats insertObjects:meats atIndexes:indexes];
}

- (void)removeObjectFromMeatsAtIndex:(NSUInteger)index
{
    [_meats removeObjectAtIndex:index];
}

- (void)removeMeatsAtIndexes:(NSIndexSet *)indexes
{
    [_meats removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest
                requestWithURL:kURLRecipeMeatsEndpoint delegate:self];
        
        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request setCachePolicy:cachePolicy];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject = [(TTURLJSONResponse *)[request response]
            rootObject];
    NSArray *rawMeats;
    NSMutableArray *mutableMeats =
            [self mutableArrayValueForKey:kMutableMeatsKey];
    
    if (![rootObject isKindOfClass:[NSDictionary class]]) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    if ((rawMeats = [rootObject objectForKey:kMeatsKey]) == nil) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    if (![rawMeats isKindOfClass:[NSArray class]]) {
        [self didFailLoadWithError:
                BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
        return;
    }
    for (NSDictionary *rawMeat in rawMeats) {
        Meat *meat = [Meat shortMeatFromDictionary:rawMeat];
        
        if (meat == nil) {
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject) tryAgain:NO];
            return;
        }
        [mutableMeats addObject:meat];
    }
    [super requestDidFinishLoad:request];
}

@end

@implementation RecipeCategory

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_categoryId release];
    [_name release];
    [_recipeCount release];
    [super dealloc];
}

#pragma mark -
#pragma mark RecipeCategory (Public)

@synthesize categoryId = _categoryId, name = _name, recipeCount = _recipeCount,
        subcategoriesCount = _subcategoriesCount;

+ (id)recipeCategoryFromDictionary:(NSDictionary *)rawRecipeCategory
{
    NSNumber *categoryId, *recipeCount, *subcategoriesCount;
    NSString *name;

    if (![rawRecipeCategory isKindOfClass:[NSDictionary class]])
        return nil;
    if ((categoryId =
            [rawRecipeCategory objectForKey:kRecipeCategoryIdKey]) == nil)
        return nil;
    if (![categoryId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawRecipeCategory objectForKey:kRecipeCategoryNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((recipeCount =
            [rawRecipeCategory objectForKey:kRecipeCategoryCountKey]) == nil)
        return nil;
    if (![recipeCount isKindOfClass:[NSNumber class]])
        return nil;
    if ((subcategoriesCount =
            [rawRecipeCategory objectForKey:kRecipeSubcategoriesCountKey]) == nil)
        return nil;
    if (![subcategoriesCount isKindOfClass:[NSNumber class]])
        return nil;

    RecipeCategory *category = [[[RecipeCategory alloc] init] autorelease];

    [category setCategoryId:categoryId];
    [category setName:name];
    [category setRecipeCount:recipeCount];
    [category setSubcategoriesCount:subcategoriesCount];
    return category;
}
@end

@implementation RecipeCategoryCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        _categories = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [_categories release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

// KVC compliance for indexed to-many collections
@synthesize categories = _categories;

- (void)insertObject:(NSURL *)categories inCategoriesAtIndex:(NSUInteger)index
{
    [_categories insertObject:categories atIndex:index];
}

- (void)insertCategories:(NSArray *)categories atIndexes:(NSIndexSet *)indexes
{
    [_categories insertObjects:categories atIndexes:indexes];
}

- (void)removeObjectFromCategoriesAtIndex:(NSUInteger)index
{
    [_categories removeObjectAtIndex:index];
}

- (void)removeCategoriesAtIndexes:(NSIndexSet *)indexes
{
    [_categories removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark RecipeCategoryCollection
@synthesize categoryId = _categoryId;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [self init]) != nil) {
        _categoryId = [categoryId copy];
    }
    return self;
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request;
        if (_categoryId == nil) {
            request = [TTURLRequest requestWithURL:kURLRecipeCategoriesEndpoint
                    delegate:self];
        } else {
            request = [TTURLRequest requestWithURL:
                    URL(kURLRecipeSubcategoryEndpoint, _categoryId)
                    delegate:self];
        }

        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    NSArray *rawCategories;
    NSMutableArray *mutableCategories =
            [self mutableArrayValueForKey:kMutableCategoriesKey];

    if (![rootObject isKindOfClass:[NSDictionary class]]){
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
            tryAgain:NO];
        return;
    }
    if ((rawCategories = [rootObject objectForKey:
            kRecipeCategoryCollectionCategoriesKey]) == nil){
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
            tryAgain:NO];
        return;
    }
    for (NSDictionary *rawRecipeCategory in rawCategories) {
        RecipeCategory *recipeCategory =
                [RecipeCategory recipeCategoryFromDictionary:rawRecipeCategory];

        if (recipeCategory == nil){
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
            tryAgain:NO];
            return;
        }
        [mutableCategories addObject:recipeCategory];
    }
    [super requestDidFinishLoad:request];
}
@end

@implementation Ingredient

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_quantity release];
    [_name release];
    [_comment release];
    [super dealloc];
}

#pragma mark -
#pragma mark Ingredient (Public)

@synthesize quantity = _quantity, name = _name,
    comment = _comment;

+ (id)ingredientFromDictionary:(NSDictionary *)rawIngredient
{
    NSString *quantity, *name, *comment;

    if (![rawIngredient isKindOfClass:[NSDictionary class]])
        return nil;
    if ((name =
            [rawIngredient objectForKey:kIngredientNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((quantity = [rawIngredient objectForKey:kIngredientQuantityKey]) == nil)
        return nil;
    if (![quantity isKindOfClass:[NSString class]]){
        if (![quantity isKindOfClass:[NSNull class]])
            return nil;
        quantity = @"";
    }
    if ((comment = [rawIngredient objectForKey:kIngredientCommentKey]) == nil)
        return nil;
    if (![comment isKindOfClass:[NSString class]]){
        if (![comment isKindOfClass:[NSNull class]])
            return nil;
        comment = @"";
    }

    Ingredient *ingredient = [[[Ingredient alloc] init] autorelease];

    [ingredient setQuantity:quantity];
    [ingredient setName:name];
    [ingredient setComment:comment];
    return ingredient;
}

- (NSString *)formattedIngredientString
{
    return [NSString stringWithFormat:@"%@ %@ %@", _quantity, _name, 
            _comment];
}
@end

@implementation Recipe

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        // Initialiazing only the mutable arrays
        _extraPictureURLs = [[NSMutableArray alloc] init];
        _ingredients = [[NSMutableArray alloc] init];
        _procedures = [[NSMutableArray alloc] init];
        _features = [[NSMutableArray alloc] init];
        _tips = [[NSMutableArray alloc] init];
    }
    return self;
}

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
    [_tips release];
    [_rations release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

// KVC compliance for indexed to-many collections
@synthesize extraPictureURLs = _extraPictureURLs, ingredients = _ingredients,
    procedures = _procedures, features = _features, tips = _tips;

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

- (void)insertObject:(NSString *)tips inTipsAtIndex:(NSUInteger)index
{
    [_tips insertObject:tips atIndex:index];
}

- (void)insertTips:(NSArray *)tips atIndexes:(NSIndexSet *)indexes
{
    [_tips insertObjects:tips atIndexes:indexes];
}

- (void)removeObjectFromTipsAtIndex:(NSUInteger)index
{
    [_tips removeObjectAtIndex:index];
}

- (void)removeTipsAtIndexes:(NSIndexSet *)indexes
{
    [_tips removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark Recipe (Public)

@synthesize recipeId = _recipeId, code = _code, name = _name,
    pictureURL = _pictureURL, price = _price, rations = _rations;

+ (id)shortRecipeFromDictionary:(NSDictionary *)rawRecipe
{
    NSNumber *recipeId;
    NSString *name, *pictureURL;

    if (![rawRecipe isKindOfClass:[NSDictionary class]])
        return nil;
    if ((recipeId = [rawRecipe objectForKey:kRecipeIdKey]) == nil)
        return nil;
    if (![recipeId isKindOfClass:[NSNumber class]])
        return nil;
    if ((name = [rawRecipe objectForKey:kRecipeNameKey]) == nil)
        return nil;
    if (![name isKindOfClass:[NSString class]])
        return nil;
    if ((pictureURL = [rawRecipe objectForKey:kRecipePictureURLKey]) == nil)
        return nil;
    if (![pictureURL isKindOfClass:[NSString class]]) {
        if (![pictureURL isKindOfClass:[NSNull class]])
            return nil;
        pictureURL = nil;
    }

    Recipe *recipe = [[[Recipe alloc] init] autorelease];

    [recipe setRecipeId:recipeId];
    [recipe setName:name];
    if (pictureURL != nil)
        [recipe setPictureURL:[NSURL URLWithString:pictureURL]];
    return recipe;
}

+ (id)recipeFromDictionary:(NSDictionary *)rawRecipe
{
    Recipe *recipe = [self shortRecipeFromDictionary:rawRecipe];

    if (recipe == nil)
        return nil;

    NSString *code;
    NSNumber *price, *rations;
    NSArray *extraPictureURLs, *ingredients, *procedures, *features, *tips;
    NSMutableArray *mutableExtraPictureURLs =
            [recipe mutableArrayValueForKey:kMutableExtraPictureURLsKey]; 
    NSMutableArray *mutableIngredients =
            [recipe mutableArrayValueForKey:kMutableIngredientsKey]; 
    NSMutableArray *mutableProcedures =
            [recipe mutableArrayValueForKey:kMutableProceduresKey]; 
    NSMutableArray *mutableFeatures =
            [recipe mutableArrayValueForKey:kMutableFeaturesKey]; 
    NSMutableArray *mutableTips =
            [recipe mutableArrayValueForKey:kMutableTipsKey];

    if ((code = [rawRecipe objectForKey:kRecipeCodeKey]) == nil)
        return nil;
    if (![code isKindOfClass:[NSString class]])
        return nil;
    if ((extraPictureURLs =
            [rawRecipe objectForKey:kRecipeExtraPictureURLsKey]) == nil)
        return nil;
    if ((price = [rawRecipe objectForKey:kRecipePriceKey]) == nil)
        return nil;
    if (![price isKindOfClass:[NSNumber class]]){
        if (![price isKindOfClass:[NSNull class]])
            return nil;
        price=nil;
    }
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
    if ((tips = [rawRecipe objectForKey:kRecipeTipsKey]) == nil)
        return nil;
    if (![tips isKindOfClass:[NSArray class]])
        return nil;
    if ((rations = [rawRecipe objectForKey:kRecipeRationsKey]) == nil)
        return nil;
    if (![rations isKindOfClass:[NSNumber class]])
        return nil;
    [recipe setCode:code];
    [recipe setPrice:price];
    [recipe setRations:rations];
    for (NSString *extraPictureURL in extraPictureURLs) {
        if (!([extraPictureURL isKindOfClass:[NSString class]] &&
                [NSURL validateURL:extraPictureURL]))
            // Quit!
            return nil;
        [mutableExtraPictureURLs addObject:
                [NSURL URLWithString:extraPictureURL]];
    }
    for (NSDictionary *rawIngredient in ingredients) {
        Ingredient *ingredient =
                [Ingredient ingredientFromDictionary:rawIngredient];

        if (ingredient == nil)
            // Quit!
            return nil;
        [mutableIngredients addObject:ingredient];
    }
    for (NSString *procedure in procedures) {
        if (![procedure isKindOfClass:[NSString class]])
            // Quit!
            return nil;
        [mutableProcedures addObject:procedure];
    }
    for (NSString *feature in features) {
        if (![feature isKindOfClass:[NSString class]])
            // Quit!
            return nil;
        [mutableFeatures addObject:feature];
    }
    for (NSString *tip in tips) {
        if (![tip isKindOfClass:[NSString class]])
            // Quit!
            return nil;
        [mutableTips addObject:tip];
    }
    return recipe;
}

- (id)initWithRecipeId:(NSString *)recipeId
{
    NSInteger recipeIntegerId = [recipeId integerValue];
    if(recipeIntegerId < 0) {
        return nil;
    }
    if((self = [self init]) != nil)
        [self setRecipeId:[NSNumber numberWithInteger:recipeIntegerId]];
    return self;
}

- (void)copyPropertiesFromRecipe:(Recipe *)recipe
{
    [self setRecipeId:[recipe recipeId]];
    [self setCode:[[recipe code] copy]];
    [self setName:[[recipe name] copy]];
    [self setPictureURL:[recipe pictureURL]];
    [self setPrice:[recipe price]];
    [self setRations:[recipe rations]];

    NSMutableArray *extraPictureURLs =
            [self mutableArrayValueForKey:kMutableExtraPictureURLsKey];
    NSMutableArray *ingredients =
            [self mutableArrayValueForKey:kMutableIngredientsKey];
    NSMutableArray *procedures =
            [self mutableArrayValueForKey:kMutableProceduresKey];
    NSMutableArray *features =
            [self mutableArrayValueForKey:kMutableFeaturesKey];
    NSMutableArray *tips = [self mutableArrayValueForKey:kMutableTipsKey];

    for (NSURL *extraPictureURL in [recipe extraPictureURLs])
        [extraPictureURLs addObject:extraPictureURLs];
    for (Ingredient *ingredient in [recipe ingredients])
        [ingredients addObject:ingredient];
    for (NSString *procedure in [recipe procedures])
        [procedures addObject:procedure];
    for (NSString *feature in [recipe features])
        [features addObject:feature];
    for (NSString *tip in [recipe tips])
        [tips addObject:tip];
}

- (BOOL)isColdMeal
{
    return [[self features] count] > 0; 
}

- (ShoppingList *)createShoppingList
{
    NSManagedObjectContext *context =
            [(AppDelegate *)[[UIApplication sharedApplication]
                delegate] context];
    NSString *recipeTitle = [self name];
    ShoppingList *shoppingList =
            [ShoppingList shoppingListWithName:[ShoppingList
                resolveNewNameFromName:recipeTitle]
                context:context];
    NSArray *ingredients;

    if ([self isColdMeal]) {
        Ingredient *ingredient = [[[Ingredient alloc] init] autorelease];
        [ingredient setQuantity:@""];
        [ingredient setName:recipeTitle];
        [ingredient setComment:@""];
        ingredients = [NSArray arrayWithObject:ingredient];
    } else {
        ingredients = [self ingredients];
    }
    for (Ingredient *ingredient in ingredients) {
        NSString *itemName = [ingredient name];

        [ShoppingItem shoppingItemWithName:itemName
                quantity:[ingredient quantity] list:shoppingList
                context:context];

        NSExpression *lhs = [NSExpression 
                expressionForKeyPath:kShoppingListName];
        NSExpression *rhs = [NSExpression expressionForConstantValue:itemName];
        NSPredicate *predicate =
                [NSComparisonPredicate predicateWithLeftExpression:lhs
                    rightExpression:rhs
                    modifier:NSDirectPredicateModifier
                    type:NSEqualToPredicateOperatorType
                    options:0];
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

        [request setEntity:[ShoppingHistoryEntry entity]];
        [request setPredicate:predicate];

        NSArray *entries = [context executeFetchRequest:request];
        if ([entries count] > 0)
            [ShoppingHistoryEntry historyEntryWithName:itemName
                    context:context];
    }
    [context save];
    return shoppingList;
}

- (void)confirmFinishLoad{
    _didFinishCount += 1;
    if (_didFinishCount == 2){
    }
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request = [TTURLRequest requestWithURL:
                URL(kURLRecipeDetailEndpoint, _recipeId) delegate:self]; 

        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    Recipe *recipe = [Recipe recipeFromDictionary:rootObject];

    if (recipe == nil) {
        [self didFailLoadWithError:BACKEND_ERROR([request urlPath], rootObject)
            tryAgain:NO];
        return;
    }
    [self copyPropertiesFromRecipe:recipe];
    [super requestDidFinishLoad:request];
}
@end

@implementation RecipeCollection

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil) {
        // Initialiazing only the mutable arrays
        _sections = [[NSMutableArray alloc] init];
        _sectionTitles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_sections release];
    [_sectionTitles release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSObject (NSKeyValueCoding)

- (void)insertObject:(Recipe *)recipe inSectionsAtIndex:(NSUInteger)index
{
    [_sections insertObject:recipe atIndex:index];
}

- (void)insertSections:(NSArray *)recipes atIndexes:(NSIndexSet *)indexes
{
    [_sections insertObjects:recipes atIndexes:indexes];
}

- (void)removeObjectFromSectionsAtIndex:(NSUInteger)index
{
    [_sections removeObjectAtIndex:index];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes
{
    [_sections removeObjectsAtIndexes:indexes];
}

- (void)insertObject:(Recipe *)recipe inSectionTitlesAtIndex:(NSUInteger)index
{
    [_sectionTitles insertObject:recipe atIndex:index];
}

- (void)insertSectionTitles:(NSArray *)recipes atIndexes:(NSIndexSet *)indexes
{
    [_sectionTitles insertObjects:recipes atIndexes:indexes];
}

- (void)removeObjectFromSectionTitlesAtIndex:(NSUInteger)index
{
    [_sectionTitles removeObjectAtIndex:index];
}

- (void)removeSectionTitlesAtIndexes:(NSIndexSet *)indexes
{
    [_sectionTitles removeObjectsAtIndexes:indexes];
}

#pragma mark -
#pragma mark RecipeCollection (Public)

@synthesize collectionId = _collectionId, sections = _sections,
    sectionTitles = _sectionTitles;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [self init]) != nil) {
        _collectionId = [categoryId copy];
        _collectionEndpointURL = URL(kURLRecipeAlphabeticEndpoint,
                _collectionId);
        _isFromMeat = NO;
    }
    return self;
}

- (id)initWithMeatId:(NSString *)meatId
{
    if ((self = [self init]) != nil) {
        _collectionId = [meatId copy];
        _collectionEndpointURL = URL(kURLRecipeAlphabeticMeatEndpoint,
                _collectionId);
        _isFromMeat = YES;
    }
    return self;
}

- (NSArray *)sectionIndexTitles
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

#pragma mark -
#pragma mark <TTModel>

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (![self isLoading]) {
        TTURLRequest *request =
                [TTURLRequest requestWithURL: _collectionEndpointURL 
                    delegate:self];

        ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy);
        [request setResponse:[[[TTURLJSONResponse alloc] init] autorelease]];
        [request send];
    }
}

#pragma mark -
#pragma mark <TTURLRequestDelegate>

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
    NSDictionary *rootObject =
            [(TTURLJSONResponse *)[request response] rootObject];
    NSArray *letters;
    UILocalizedIndexedCollation *collation =
            [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *mutableSections =
            [self mutableArrayValueForKey:kMutbaleSectionsKey];
    NSMutableArray *mutableSectionTitles =
            [self mutableArrayValueForKey:kMutableSectionTitlesKey];

    if (![rootObject isKindOfClass:[NSDictionary class]])
        return;
    if ((letters =
            [rootObject objectForKey:kRecipeCollectionLettersKey]) == nil)
        return;

    for (NSDictionary *recipeCluster in letters) {
        NSArray *rawRecipesInSection;
        NSString *sectionName;

        if (![recipeCluster isKindOfClass:[NSDictionary class]]){
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
            return;
        }
        if ((sectionName =
                [recipeCluster objectForKey:kRecipeCollectionLetterKey]) 
                    == nil){
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
            return;
        }
        if (![sectionName isKindOfClass:[NSString class]]){
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
            return;
        }
        if ((rawRecipesInSection = [recipeCluster objectForKey:
                kRecipeCollectionRecipesKey]) == nil){
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
            return;
        }
        if (![rawRecipesInSection isKindOfClass:[NSArray class]]){
            [self didFailLoadWithError:
                    BACKEND_ERROR([request urlPath], rootObject)
                tryAgain:NO];
            return;
        }

        NSMutableArray *recipesInSection =
                [NSMutableArray arrayWithCapacity:[rawRecipesInSection count]];

        [mutableSectionTitles addObject:sectionName];
        [collation sectionForObject:sectionName
                collationStringSelector:@selector(description)];
        for (NSDictionary *rawRecipe in rawRecipesInSection) {
            Recipe *recipe = [Recipe shortRecipeFromDictionary:rawRecipe];

            if (recipe == nil){
                [self didFailLoadWithError:
                        BACKEND_ERROR([request urlPath], rootObject)
                    tryAgain:NO];
                return;
            }

            NSURL *pictureURL = [recipe pictureURL];
            NSString *controllerURL = _isFromMeat ?
                    URL(kURLRecipeMeatsDetailCall, [recipe recipeId],
                        kRecipeMiscYes) :
                    URL(kURLRecipeDetailCall, [recipe recipeId]);

            if (pictureURL != nil)
                pictureURL = IMAGE_URL(pictureURL, kRecipeListImageWidth,
                        kRecipeListImageHeigth);

            TableImageSubtitleItem *item = 
                    [TableImageSubtitleItem itemWithText:[recipe name]
                        subtitle:nil imageURL:[pictureURL absoluteString]
                        defaultImage:TTIMAGE(kRecipeListDefaultImage)
                        URL:controllerURL];

            [recipesInSection addObject:item];
        }
        [mutableSections addObject:recipesInSection];
    }
    [super requestDidFinishLoad:request];
}
@end
