#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/EntityDescription.h"

@implementation EntityDescription

#pragma mark -
#pragma mark <EntityDescription>

+ (void)    createEntities:(NSSet **)entities
    localizationDictionary:(NSDictionary **)localizationDictionary
{
    // ShoppingList Entity
    NSEntityDescription *shoppingList =
            [[[NSEntityDescription alloc] init] autorelease];

    [shoppingList setName:@"ShoppingList"];
    [shoppingList setManagedObjectClassName:@"ShoppingList"];

    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:@"name"];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *lastModificationDate =
            [[[NSAttributeDescription alloc] init] autorelease];

    [lastModificationDate setName:@"lastModificationDate"];
    [lastModificationDate setAttributeType:NSDateAttributeType];
    [lastModificationDate setOptional:NO];
    [lastModificationDate setDefaultValue:[NSNull null]];

    NSAttributeDescription *order =
            [[[NSAttributeDescription alloc] init] autorelease];

    [order setName:@"order"];
    [order setAttributeType:NSInteger32AttributeType];
    [order setOptional:NO];
    [order setDefaultValue:[NSNumber numberWithInteger:0]];
    [order setIndexed:YES];
    // setting properties into the entity
    [shoppingList setProperties:[NSArray arrayWithObjects:
            name, lastModificationDate, order, nil]];
    // return configured entities
    *entities = [NSSet setWithObjects:shoppingList, nil];
    // return configured localizationDictionary
    *localizationDictionary = [NSDictionary dictionary];
}
@end
