#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Models/ManagedObject.h"
#import "Common/Models/ReorderingManagedObject.h"

@implementation ReorderingManagedObject

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *order =
            [[[NSAttributeDescription alloc] init] autorelease];

    [order setName:@"order"];
    [order setAttributeType:NSInteger32AttributeType];
    [order setOptional:NO];
    [order setIndexed:YES];
    [order setDefaultValue:[NSNumber numberWithInteger:0]];
    return [attributes setByAddingObject:order];
}

#pragma mark -
#pragma mark ReorderingManagedObject

@dynamic order;

+ (id)orderedObjectWithContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

    [request setEntity:self];
    
    NSArray *objects = [context executeFetchRequest:request];

    if (objects == nil)
        return nil;

    ReorderingManagedObject *object =
            [[[ReorderingManagedObject alloc] initWithEntity:[self entity]
                insertIntoManagedObjectContext:context] autorelease];
    NSInteger order =
            [[objects valueForKeyPath:@"@max.order"] integerValue] + 1;

    [object setOrder:[NSNumber numberWithInteger:order]];
    return object;
}

+ (id)orderedObjectWithResultsController:
    (NSFetchedResultsController *)resultsController
{
    ReorderingManagedObject *object =
            [[[ReorderingManagedObject alloc] initWithEntity:[self entity]
                insertIntoManagedObjectContext:
                    [resultsController managedObjectContext]] autorelease];
    NSInteger order =
            [[[resultsController fetchedObjects]
                valueForKeyPath:@"@max.order"] integerValue] + 1;

    [object setOrder:[NSNumber numberWithInteger:order]];
    return object;
}
@end
