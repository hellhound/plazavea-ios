#import <Foundation/Foundation.h>

@protocol EntityDescription <NSObject>

@required
// entities and localizationDictionary are guaranteed to be defined
// (i.e. non NULL). There's no need to check for null pointers.
+ (void)    createEntities:(NSSet **)entities
    localizationDictionary:(NSDictionary **)localizationDictionary 
                   context:(NSManagedObjectContext *)context;
@end
