/*
 * This isn't intended to use alone, you should #import Foundation/Foundation.h
 * and Three20/Three20.h
 */
// Define HOST_NAME and ENDPOINT_BASE_URL
#ifdef DEBUG
#define HOST_NAME @"demos.bitzeppelin.com"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"spsa/api"
#else
#define HOST_NAME @"demos.bitzeppelin.com"
#define ENDPOINT_BASE_URL @"http://" HOST_NAME @"spsa/api"
#endif

// CoreData constants

#define SQL_STORE_FILE @"plaza-vea-movil.sqlite"
#define UNDO_LEVEL 0

// App constants

#define DATE_FORMAT @"dd'/'MM'/'yyyy HH':'mm"

// Macros

#define URL(...) [NSString stringWithFormat:__VA_ARGS__]
