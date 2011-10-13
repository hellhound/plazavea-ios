#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Launcher/Constants.h"
#import "Launcher/LauncherViewController.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListsController.h"
#import "Recipes/Constants.h"
#import "Recipes/MeatListController.h"
#import "Recipes/RecipeCategoryController.h"
#import "Recipes/RecipeListController.h"
#import "Recipes/RecipeDetailController.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_window release];
    [_context release];
    [_model release];
    [_coordinator release];
    [_dateFormatter release];
    [super dealloc];
}

#pragma mark -
#pragma mark AppDelegate (Public)

#pragma mark -
#pragma mark <UIApplicationDelegate>

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)options
{
    _window = [[UIWindow alloc] initWithFrame:TTScreenBounds()];

    TTNavigator *navigator = [TTNavigator navigator];
    [navigator setWindow:_window];
    TTURLMap *map = [navigator URLMap];

    // Launcher
    [map from:kURLLauncher toViewController:[LauncherViewController class]];
    // Shopping lists
    // ShoppingListsController isn't a TTViewController so we MUST provide a
    // custom selector for initialization
    [map from:kURLShoppingLists
            toViewController:[ShoppingListsController class]
            selector:@selector(init)];
    // Recipes
    [map from:kURLMeats toModalViewController:[MeatListController class]
            transition:UIModalTransitionStyleFlipHorizontal];
    [map from:kURLRecipeCategories
            toViewController:[RecipeCategoryController class]];
    [map from:kURLRecipeSubcategories
            toViewController:[RecipeCategoryController class]];
    [map from:kURLRecipeList toViewController:[RecipeListController class]];
    [map from:kURLRecipeMeatList toViewController:[RecipeListController class]];
    [map from:kURLRecipeDetail toViewController:[RecipeDetailController class]];
    [map from:kURLRecipeMeatsDetail
            toViewController:[RecipeDetailController class]];
    // Open root view controller
    [navigator openURLAction:
            [[TTURLAction actionWithURLPath:kURLLauncherCall]
            applyAnimated:YES]];
    [_window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)URL
{
    [[TTNavigator navigator] openURLAction:
            [[TTURLAction actionWithURLPath:
                [URL absoluteString]] applyAnimated:YES]];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the
    // application terminates.
    [self saveContext];
}

#pragma mark -
#pragma mark <TTNavigatorDelegate>

- (BOOL)navigator:(TTNavigator *)navigator shouldOpenURL:(NSURL *)URL
{
    // FIXME: Opens URLs systematically!!!
    return YES;
}
@end
