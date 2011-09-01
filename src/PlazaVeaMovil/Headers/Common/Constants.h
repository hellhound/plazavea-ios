/*
 * This isn't intended to use alone, you should #import Foundation/Foundation.h
 * and Three20/Three20.h
 */
// Define HOST_NAME and ENDPOINT_BASE_URL
#ifdef DEBUG
#define HOST_NAME @"demos.bitzeppelin.com"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/spsa/api"
#else
#define HOST_NAME @"demos.bitzeppelin.com"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/spsa/api"
#endif

// CoreData constants

#define SQL_STORE_FILE @"plaza-vea-movil.sqlite"
#define UNDO_LEVEL 0

// App constants

#define DATE_FORMAT @"dd'/'MM'/'yyyy HH':'mm"

// Macros

// Endpoint-construction helper
#define ENDPOINT(x) ENDPOINT_BASE_URL x
// Helper for forming URL calls
#define URL(...) [NSString stringWithFormat:__VA_ARGS__]
// Helper for adding cache policy depending on URLRequestModel's property:
// isTryingCache
#define ADD_DEFAULT_CACHE_POLICY_TO_REQUEST(request, cachePolicy) \
        if ([self isTryingCache]) { \
            [request setCachePolicy:cachePolicy]; \
        } else { \
            [request setCachePolicy:cachePolicy | \
                TTURLRequestCachePolicyEtag]; \
        } \
        [request setCacheExpirationAge:TT_DEFAULT_CACHE_EXPIRATION_AGE]

//Define the colors for the navigation bar and toolbar
#define BAR_COLOR [UIColor colorWithRed:1 green:0.867 blue:0 alpha:1]
//Define the UIImage for the banner

#define LOGOTYPE [UIImage imageNamed:@"plazaVeaLogo.png"]
