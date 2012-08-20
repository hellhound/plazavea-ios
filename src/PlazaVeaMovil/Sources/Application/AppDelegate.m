#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <Three20/Three20.h>

#import <extThree20JSON/extThree20JSON.h>

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
#import "Recipes/IngredientRecipeDetailController.h"
#import "Recipes/ProcedureRecipeDetailController.h"
#import "Recipes/TipsRecipeDetailController.h"
#import "Recipes/ContributionRecipeDetailController.h"
#import "Recipes/FeaturesRecipeDetailController.h"
#import "Offers/Constants.h"
#import "Offers/OfferListController.h"
#import "Offers/PromotionListController.h"
#import "Offers/OfferDetailController.h"
#import "Offers/PromotionDetailController.h"
#import "Stores/Constants.h"
#import "Stores/RegionListController.h"
#import "Stores/StoreListController.h"
#import "Stores/StoreDetailController.h"
#import "Stores/StoreMapController.h"
#import "BodyMeter/Constants.h"
#import "BodyMeter/DiagnosisController.h"
#import "Emergency/Constants.h"
#import "Emergency/EmergencyCategoryController.h"
#import "Wines/Constants.h"
#import "Wines/StrainListController.h"
#import "Wines/WineListController.h"
#import "Wines/WineDetailController.h"
#import "Wines/WineInfoController.h"
#import "Wines/WineTasteController.h"
#import "Wines/WineTipsController.h"
#import "Wines/WineFilterController.h"
#import "Wines/FilteringListController.h"
#import "Wines/WinePictureController.h"
#import "Composition/Constants.h"
#import "Composition/FoodCategoryListController.h"
#import "Composition/FoodDetailController.h"
#import "Application/StyleSheet.h"
#import "Application/Constants.h"
#import "Application/AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, retain) UIWindow *overlay;

- (void)showWorking;
- (void)hideWorking;
- (void)fadeDefault;
- (BOOL)loadDefaults;
@end

@implementation AppDelegate

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_window release];
    [_facebook release];
    [_twitter release];
    [_context release];
    [_model release];
    [_coordinator release];
    [_dateFormatter release];
    [super dealloc];
}

#pragma mark -
#pragma mark AppDelegate (Public)

@synthesize window = _window, facebook = _facebook, twitter = _twitter,
        overlay = _overlay, receivedData = _receivedData;

- (NSString *)getUUID {
    //get a UUID value from UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuidStr = [defaults stringForKey:kApplicationUUIDKey];

    if (uuidStr == nil) {
        CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);

        uuidStr = [(NSString *)CFUUIDCreateString(
                kCFAllocatorDefault, uuidObject) autorelease];
        CFRelease(uuidObject);
        [defaults setObject:uuidStr forKey:kApplicationUUIDKey];
        [defaults synchronize];
    }
    return uuidStr;
}

#pragma mark -
#pragma mark AppDelegate (Private)

- (void)showWorking
{
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
            beforeDate:[NSDate date]];
    
    _overlay = [[UIWindow alloc] initWithFrame:
            [[UIScreen mainScreen] bounds]];
    UIActivityIndicatorView *indicator = [[[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:
                UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    
    [indicator setFrame:CGRectOffset([indicator frame],
            ([_overlay frame].size.width - [indicator frame].size.width) / 2.,
                kIndicatorY)];
    [indicator startAnimating];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [label setText:kWorkingMessage];
    [label setFont:[UIFont boldSystemFontOfSize:kLabelFontSize]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    
    CGSize labelSize = [[label text] sizeWithFont:[label font]
            constrainedToSize:CGSizeMake([_overlay bounds].size.width,
                [_overlay bounds].size.height)
                lineBreakMode:UILineBreakModeWordWrap];
    
    [label setFrame:CGRectMake(([_overlay frame].size.width - labelSize.width) /
            2., kLabelY, labelSize.width, labelSize.height)];
    [_overlay addSubview:indicator];
    [_overlay addSubview:label];
    [_overlay setBackgroundColor:[UIColor blackColor]];
    [_overlay setAlpha:.0];
    [_overlay makeKeyAndVisible];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kAnimationDuration];
    [_overlay setAlpha:kOverlayAlpha];
    [UIView commitAnimations];
}

- (void)hideWorking
{
    [_overlay release];
    [_window makeKeyAndVisible];
}

- (void)fadeDefault
{
    UIImageView *splash = [[[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"Default.png"]] autorelease];
    
    [splash setTag:100];
    [_window insertSubview:splash atIndex:0];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.8];
    [splash setAlpha:.0];
    [UIView commitAnimations];
    [splash removeFromSuperview];
}

- (BOOL)loadDefaults
{
    [self getUUID];
    BOOL registrationIsComplete = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kDNIDefault] == nil)
        registrationIsComplete = NO;
    if ([defaults objectForKey:kPhoneDefault] == nil)
        registrationIsComplete = NO;
    if ([defaults objectForKey:kEmailDefault] == nil)
        registrationIsComplete = NO;
    return registrationIsComplete;
}

#pragma mark -
#pragma mark <UIApplicationDelegate>

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)options
{
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(showWorking) name:kCoreDataDidBegin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(hideWorking) name:kCoreDataDidEnd object:nil];
    // Conf Facebook
    _facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kAccessTokenKey] &&
            [defaults objectForKey:kExpirationDateKey]) {
        [_facebook setAccessToken:[defaults objectForKey:kAccessTokenKey]];
        [_facebook setExpirationDate:
                [defaults objectForKey:kExpirationDateKey]];
    }
    // Conf Twitter
    _twitter = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
    
    [_twitter setConsumerKey:kOAuthConsumerKey];
    [_twitter setConsumerSecret:kOAuthConsumerSecret];
    // Style sheet
    [TTStyleSheet setGlobalStyleSheet:[[[StyleSheet alloc] init] autorelease]];
    // Set the maxContentLength to auto
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];

    _window = [[UIWindow alloc] initWithFrame:TTScreenBounds()];

    TTNavigator *navigator = [TTNavigator navigator];
    [navigator setWindow:_window];
    TTURLMap *map = [navigator URLMap];

    // Launcher
    [map from:kURLLauncher
            toViewController:[LauncherViewController class]];
    // Shopping lists
    // ShoppingListsController isn't a TTViewController so we MUST provide a
    // custom selector for initialization
    [map from:kURLShoppingLists
            toViewController:[ShoppingListsController class]
                selector:@selector(init)];
    // BodyMeter
    [map from:kURLBodyMeterDiagnosis
            toViewController:[DiagnosisController class]
                selector:@selector(init)];
    // Recipes
    [map from:kURLMeats
            toModalViewController:[MeatListController class]
                transition:UIModalTransitionStyleFlipHorizontal];
    [map from:kURLRecipeCategories
            toViewController:[RecipeCategoryController class]];
    [map from:kURLRecipeSubcategories
            toViewController:[RecipeCategoryController class]];
    [map from:kURLRecipeList
            toViewController:[RecipeListController class]];
    [map from:kURLRecipeMeatList
            toViewController:[RecipeListController class]];
    [map from:kURLRecipeDetail
            toViewController:[RecipeDetailController class]];
    [map from:kURLRecipeMeatsDetail
            toViewController:[RecipeDetailController class]];
    [map from:kURLIngredientRecipeDetail
            toViewController:[IngredientRecipeDetailController class]];
    [map from:kURLProceduresRecipeDetail
            toViewController:[ProcedureRecipeDetailController class]];
    [map from:kURLTipsRecipeDetail
            toViewController:[TipsRecipeDetailController class]];
    [map from:kURLIngredientRecipeMeatsDetail
            toViewController:[IngredientRecipeDetailController class]];
    [map from:kURLProceduresRecipeMeatsDetail
            toViewController:[ProcedureRecipeDetailController class]];
    [map from:kURLTipsRecipeMeatsDetail
            toViewController:[TipsRecipeDetailController class]];
    [map from:kURLContributionRecipeDetail
            toViewController:[ContributionRecipeDetailController class]];
    [map from:kURLFeaturesRecipeDetail
            toViewController:[FeaturesRecipeDetailController class]];
    // Offers
    [map from:kURLOfferList
            toViewController:[OfferListController class]];
    [map from:kURLPromotionList
            toModalViewController:[PromotionListController class]
                transition:UIModalTransitionStyleFlipHorizontal];
    [map from:kURLOfferDetail
            toViewController:[OfferDetailController class]];
    [map from:kURLPromotionDetail
            toViewController:[PromotionDetailController class]];
    // Stores
    [map from:kURLRegionList
            toViewController:[RegionListController class]];
    [map from:kURLSubregionList
            toViewController:[RegionListController class]];
    [map from:kURLStoreList
            toViewController:[StoreListController class]];
    [map from:kURLStoreDetail
            toViewController:[StoreDetailController class]];
    [map from:kURLStoreMap
            toModalViewController:[StoreMapController class]
                transition:UIModalTransitionStyleFlipHorizontal];
    [map from:kURLStoreDetailMap
            toModalViewController:[StoreMapController class]
                transition:UIModalTransitionStyleFlipHorizontal];
    // Emergency numbers
    [map from:kURLEmergencyCategory
            toViewController:[EmergencyCategoryController class]
                selector:@selector(init)];
    // Somelier
    [map from:kURLStrainList
            toViewController:[StrainListController class]];
    [map from:kURLRecipeStrainList
            toViewController:[StrainListController class]];
    [map from:kURLWineList
            toViewController:[WineListController class]];
    [map from:kURLWinesForRecipeList
            toViewController:[WineListController class]];
    [map from:kURLWineDetail
            toViewController:[WineDetailController class]];
    [map from:kURLWineInfo
            toViewController:[WineInfoController class]];
    [map from:kURLWineTaste
            toViewController:[WineTasteController class]];
    [map from:kURLWineTips
            toViewController:[WineTipsController class]];
    [map from:kURLWineRecipe
            toViewController:[RecipeListController class]];
    [map from:kURLWineFilter
            toViewController:[WineFilterController class]
                selector:@selector(init)];
    [map from:kURLFiltering
            toViewController:[FilteringListController class]];
    [map from:kURLWinePicture
            toViewController:[WinePictureController class]];
    [map from:kURLFilteredWineList
            toViewController:[WineListController class]];
    // Nutritional composition
    [map from:kURLFoodCategory
            toViewController:[FoodCategoryListController class]
                selector:@selector(init)];
    [map from:kURLFoodDetail
            toViewController:[FoodDetailController class]];
    // Open root view controller
    [self fadeDefault];
    [navigator openURLAction:
            [[TTURLAction actionWithURLPath:kURLLauncherCall]
             applyAnimated:YES]];
    if (![self loadDefaults]) {
        TSAlertView *alert = [[TSAlertView alloc]
                initWithTitle:kRegistrationTitle message:nil delegate:self
                    cancelButtonTitle:nil otherButtonTitles:kRegsitrationButton,
                    nil];
        
        [alert setStyle:TSAlertViewStyleInput];
        [[alert firstTextField] setPlaceholder:kDNILabel];
        [alert addTextFieldWithLabel:kPhoneLabel value:nil];
        [alert addTextFieldWithLabel:kEmailLabel value:nil];
        [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [[alert textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeNumberPad];
        [[alert textFieldAtIndex:2] setKeyboardType:UIKeyboardTypeEmailAddress];
        [[alert textFieldAtIndex:2] setAutocapitalizationType:
                UITextAutocapitalizationTypeNone];
        [alert show];
    }
    [_window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)URL
{
    /*[[TTNavigator navigator] openURLAction:
            [[TTURLAction actionWithURLPath:
                [URL absoluteString]] applyAnimated:YES]];
    return YES;*/
    return [_facebook handleOpenURL:URL];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [_facebook handleOpenURL:url];
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

#pragma mark -
#pragma mark <FBSessionDelegate>

- (void)fbDidLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[_facebook accessToken] forKey:kAccessTokenKey];
    [defaults setObject:[_facebook expirationDate] forKey:kExpirationDateKey];
    [defaults synchronize];
}

- (void)fbSessionInvalidated
{
    
}

- (void)fbDidLogout
{
    
}

- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    
}

#pragma mark -
#pragma mark <SA_OAuthTwitterEngineDelegate>

- (void)storeCachedTwitterOAuthData:(NSString *)data
                        forUsername:(NSString *)username
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:kOAuthData];
    [defaults synchronize];
}

- (NSString *)cachedTwitterOAuthDataForUsername:(NSString *)username
{    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kOAuthData];
}

#pragma mark -
#pragma mark <TSAlertViewDelegate>

- (void)   alertView:(TSAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([[[alertView textFieldAtIndex:0] text] length] == 8) {
            [defaults setObject:[[alertView textFieldAtIndex:0] text]
                    forKey:kDNIDefault];
        } else {
            [[alertView textFieldAtIndex:0] setText:nil];
        }
        if (([[[alertView textFieldAtIndex:1] text] length] == 9) ||
                ([[[alertView textFieldAtIndex:1] text] length] == 7)) {
            [defaults setObject:[[alertView textFieldAtIndex:1] text]
                    forKey:kPhoneDefault];
        } else {
            [[alertView textFieldAtIndex:1] setText:nil];
        }   
        if ([[[alertView textFieldAtIndex:2] text] length] > 0) {
            [defaults setObject:[[alertView textFieldAtIndex:2] text]
                    forKey:kEmailDefault];
        } else {
            [[alertView textFieldAtIndex:2] setText:nil];
        }
        if ([self loadDefaults]) {
            NSURL *url = [NSURL URLWithString:ENDPOINT(@"/register/")];
            NSMutableURLRequest *request = [NSMutableURLRequest
                    requestWithURL:url
                        cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:60.];
            
            [request setHTTPMethod:kPostHTTPMethod];
            [request setValue:kContentHTTPHeaderValue
                    forHTTPHeaderField:kContentHTTPHeaderKey];
            
            NSString *postString = [NSString stringWithFormat:
                    kRegisterRequestString,
                    kDNIResquestKey, [defaults objectForKey:kDNIDefault],
                    kPhoneRequestKey, [defaults objectForKey:kPhoneDefault],
                    kEmailRequestKey, [defaults objectForKey:kEmailDefault]];
            
            [request setHTTPBody:[postString dataUsingEncoding:
                    NSUTF8StringEncoding]];
                        
            NSURLConnection *connection = [[[NSURLConnection alloc]
                    initWithRequest:request delegate:self] autorelease];
            
            if (connection) {
                _receivedData = [[NSMutableData data] retain];
            }
        }
    }
}

#pragma mark -
#pragma mark <NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *response = [[[NSString alloc] initWithData:_receivedData
                encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"%@", response);
    [_receivedData release];
}
@end
