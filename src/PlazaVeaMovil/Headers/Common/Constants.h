#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Additions/NSError+Additions.h"

// Define HOST_NAME and ENDPOINT_BASE_URL
#ifdef DEBUG
//#define HOST_NAME @"demos.bitzeppelin.com"
#define HOST_NAME @"restmocker.bitzeppelin.com"
//#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/spsa/api"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/api/spsa"
#else
//#define HOST_NAME @"demos.bitzeppelin.com"
#define HOST_NAME @"restmocker.bitzeppelin.com"
//#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/spsa/api"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"/api/spsa"
#endif

// CoreData constants

#define SQL_STORE_FILE @"plaza-vea-movil.sqlite"
#define UNDO_LEVEL 0

// App constants

#define DATE_FORMAT @"dd'/'MM'/'yyyy HH':'mm"

// Macros

// NSNumber helpers 
#define N(x) [NSNumber numberWithInteger:x]
// Endpoint-construction helper
#define ENDPOINT(x) ENDPOINT_BASE_URL x
// Helper for forming URL calls
#define URL(...) [NSString stringWithFormat:__VA_ARGS__]
// Image query string
#define IMAGE_QUERY_STRING @"%@?width=%lu&height=%lu"
// Helper for image URLs with query string
#define IMAGE_URL(url, width, height) [NSURL URLWithString: \
        [NSString stringWithFormat:IMAGE_QUERY_STRING, [url absoluteString], \
            (NSUInteger)width, (NSUInteger)height]]

// Error messages and codes
#define SEVERE_ERROR \
        @"Ocurrió un error. Espere un momento, estamos trabajando para " \
        @"corregirlo y servirles mejor."
#define INTERNET_ERROR @"La conexi\u00F3n a Internet parece estar desactivada"
/*
 * 20  -> NSPOSIXErrorDomain Operation could not be completed. Invalid argument
 *        iOS pre 4.0
 * 400 -> NSURLErrorDomain Bad request
 * 401 -> NSURLErrorDomain Unauthorized
 * 403 -> NSURLErrorDomain Forbidden
 * 500 -> NSURLErrorDomain Internal server error
 * 503 -> NSURLErrorDomain Sevice unavailable
 */
#define MESSAGE_FOR_ERROR_CODES [NSDictionary dictionaryWithObjectsAndKeys: \
        INTERNET_ERROR, \
        N(22), \
        INTERNET_ERROR, \
        N(-1001), \
        SEVERE_ERROR, \
        N(400), \
        SEVERE_ERROR, \
        N(401), \
        SEVERE_ERROR, \
        N(403), \
        SEVERE_ERROR, \
        N(500), \
        SEVERE_ERROR, \
        N(503), \
        SEVERE_ERROR, \
        N(-1), \
        nil] 

#define LOCALIZED_HTTP_REQUEST_ERROR(error) \
        [error HTTPRequestErrorDescriptionWithCodes:MESSAGE_FOR_ERROR_CODES]

// BACKEND_MESSAGE format
#define BACKEND_ERROR_MESSAGE_FORMAT @"[%@]\n\n[%@]"
// Default error domain for the app
#define APPLICATION_ERROR_DOMAIN @"BZErrorDomain"
// Error codes in APPLICATION_ERROR_DOMAIN
#define BACKEND_ERROR_CODE -1
// User info for each error codes
#define BACKEND_ERROR_USERINFO(title, subtitle) \
        [NSDictionary dictionaryWithObjectsAndKeys: \
        [NSString stringWithFormat:BACKEND_ERROR_MESSAGE_FORMAT, title, \
        [[[subtitle description] stringByReplacingOccurrencesOfString:@"\n" \
            withString:@" "] substringToIndex: \
            [[subtitle description] length] > 60 ? \
                60 : [[subtitle description] length]]], \
        NSLocalizedDescriptionKey, nil]
// Define a macro for backend errors
#define BACKEND_ERROR(title, subtitle) \
        [NSError errorWithDomain:APPLICATION_ERROR_DOMAIN \
        code:BACKEND_ERROR_CODE \
        userInfo:BACKEND_ERROR_USERINFO(title, subtitle)]
#define DEFAULT_BACKEND_ERROR BACKEND_ERROR(SEVERE_ERROR, @"")

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
