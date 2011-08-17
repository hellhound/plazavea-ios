#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"

static NSEntityDescription *kRootEntity;

@interface ManagedObject (Private)

+ (void)initializeEntity;
+ (NSSet *)properties;
@end

@implementation ManagedObject

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    [self initializeEntity];
}

#pragma mark -
#pragma mark ManagedObject (Private)

+ (void)initializeEntity
{
    if ([self isSubclassOfClass:[ManagedObject class]] &&
            (kRootEntity == nil ||
            ![[kRootEntity subentities] containsObject:[self entity]])) {
        NSEntityDescription *entity = [[NSEntityDescription alloc] init];
        NSString *className = NSStringFromClass(self);

        [entity setName:className];
        [entity setManagedObjectClassName:className];
        if (kRootEntity == nil) {
            [entity setAbstract:YES];
            kRootEntity = entity;
        } else {
            // Other entities, that is non-root entities, should be autoreleased
            [entity autorelease];
            [kRootEntity setSubentities:
                    [[kRootEntity subentities] arrayByAddingObject:entity]];
            [self classDidInitialize];
        }
    }
}

+ (NSSet *)properties
{
    return [[self attributes] setByAddingObjectsFromSet:[self relationships]];
}

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (void)classDidInitialize
{
    // Allows post-initialization for subclasses and avoids an ugly bug when a
    // sub overwrites initialize
    // NO-OP
}

+ (NSSet *)attributes
{
    return [NSSet set];
}

+ (NSSet *)relationships
{
    return [NSSet set];
}

+ (NSDictionary *)localizations
{
    return [NSDictionary dictionary];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)relationshipName
{
    return nil;
}

#pragma mark -
#pragma mark ManagedObject (Framework)

+ (NSEntityDescription *)entity
{
    if (self == [ManagedObject class])
        return kRootEntity;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",
            NSStringFromClass([self class])];
    NSArray *entities =
            [[kRootEntity subentities] filteredArrayUsingPredicate:predicate];

    if ([entities count] == 0)
        return nil;
    return [entities objectAtIndex:0];
}

#pragma mark -
#pragma mark <ManagedObject>

+ (void)    createEntity:(NSEntityDescription **)entity
  localizationDictionary:(NSDictionary **)localizationDictionary 
                 context:(NSManagedObjectContext *)context
{
    *entity = [self entity];
    [*entity setProperties:[[self properties] allObjects]];
    *localizationDictionary = [self localizations];
}
@end
