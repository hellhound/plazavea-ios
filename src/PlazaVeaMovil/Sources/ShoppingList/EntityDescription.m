#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/EntityDescription.h"

@implementation EntityDescription

#pragma mark -
#pragma mark EntityDescription

+ (NSArray *)attributeDescriptionsForShoppingList
{
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
    [order setIndexed:YES];
    [order setDefaultValue:[NSNumber numberWithInteger:0]];
    // setting properties into the entity
    return [NSArray arrayWithObjects:name, lastModificationDate, order, nil];
}

+ (NSArray *)attributeDescriptionsForShoppingItem
{
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:@"name"];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *quantity =
            [[[NSAttributeDescription alloc] init] autorelease];

    [quantity setName:@"quantity"];
    [quantity setAttributeType:NSInteger32AttributeType];
    [quantity setOptional:NO];
    [quantity setDefaultValue:[NSNumber numberWithInteger:0]];

    NSAttributeDescription *order =
            [[[NSAttributeDescription alloc] init] autorelease];

    [order setName:@"order"];
    [order setAttributeType:NSInteger32AttributeType];
    [order setOptional:NO];
    [order setIndexed:YES];
    [order setDefaultValue:[NSNumber numberWithInteger:0]];
    // setting properties into the entity
    return [NSArray arrayWithObjects:name, quantity, order, nil];
}

+ (void)createShoppingListEntity:(NSEntityDescription **)listEntity
                  withAttributes:(NSArray *)listEntityAttributes
                   andItemEntity:(NSEntityDescription **)itemEntity
                  withAttributes:(NSArray *)itemEntityAttributes
{
    *listEntity =
            [[[NSEntityDescription alloc] init] autorelease];
    *itemEntity =
            [[[NSEntityDescription alloc] init] autorelease];

    [*listEntity setName:@"ShoppingList"];
    [*listEntity setManagedObjectClassName:@"ShoppingList"];
    [*itemEntity setName:@"ShoppingItem"];
    [*itemEntity setManagedObjectClassName:@"ShoppingItem"];

    NSRelationshipDescription *items =
            [[[NSRelationshipDescription alloc] init] autorelease];
    NSRelationshipDescription *list =
            [[[NSRelationshipDescription alloc] init] autorelease];

    // To-many relationship to ShoppingItem from ShoppingList
    [items setName:@"items"];
    [items setDestinationEntity:*itemEntity];
    [items setInverseRelationship:list];
    [items setOptional:NO];
    [items setMaxCount:-1]; // to-many relationship
    [items setMinCount:0];
    [items setDeleteRule:NSCascadeDeleteRule];
    // Foreign key to ShoppingList from ShoppingItem
    [list setName:@"list"];
    [list setDestinationEntity:*listEntity];
    [list setInverseRelationship:items];
    [list setOptional:NO];
    [list setMaxCount:1]; // to-one relationship
    [list setMinCount:1];
    [list setDeleteRule:NSNoActionDeleteRule];
    // Finally, add properties (attributes + relationships) to the entities
    [*listEntity setProperties:
            [listEntityAttributes arrayByAddingObject:items]];
    [*itemEntity setProperties:[itemEntityAttributes arrayByAddingObject:list]];
}

#pragma mark -
#pragma mark <EntityDescription>

+ (void)    createEntities:(NSSet **)entities
    localizationDictionary:(NSDictionary **)localizationDictionary
                   context:(NSManagedObjectContext *)context
{
    NSEntityDescription *shoppingList = nil;
    NSEntityDescription *shoppingItem = nil;

    [self createShoppingListEntity:&shoppingList
            withAttributes:[self attributeDescriptionsForShoppingList]
            andItemEntity:&shoppingItem
            withAttributes:[self attributeDescriptionsForShoppingItem]];
    // return configured entities
    *entities = [NSSet setWithObjects:shoppingList, shoppingItem, nil];
    // return configured localizationDictionary
    *localizationDictionary = [NSDictionary dictionary];
}
@end
