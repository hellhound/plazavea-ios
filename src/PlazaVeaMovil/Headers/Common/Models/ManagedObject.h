#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol ManagedObject <NSObject>

@required
// entities and localizationDictionary are guaranteed to be defined
// (i.e. non NULL). There's no need to check for null pointers.
+ (void)    createEntity:(NSEntityDescription **)entity
  localizationDictionary:(NSDictionary **)localizationDictionary 
                 context:(NSManagedObjectContext *)context;
@end

@interface ManagedObject: NSManagedObject <ManagedObject>
@end

@interface ManagedObject (Overridable)

+ (void)classDidInitialize;
+ (NSSet *)attributes;
+ (NSSet *)relationships;
+ (NSDictionary *)localizations;
+ (NSRelationshipDescription *)relationshipWithName:
    (NSString *)relationshipName;
@end

@interface ManagedObject (Framework)

+ (NSEntityDescription *)entity;
@end
