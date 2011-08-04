#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/EntityDescription.h"

@implementation EntityDescription

#pragma mark -
#pragma mark EntityDescription

+ (NSArray *)attributeDescriptionsForShoppingList
{
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kShoppingListName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *lastModificationDate =
            [[[NSAttributeDescription alloc] init] autorelease];

    [lastModificationDate setName:kShoppingListLastModificationDate];
    [lastModificationDate setAttributeType:NSDateAttributeType];
    [lastModificationDate setOptional:YES];

    NSAttributeDescription *order =
            [[[NSAttributeDescription alloc] init] autorelease];

    [order setName:kShoppingListOrder];
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

    [name setName:kShoppingItemName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *quantity =
            [[[NSAttributeDescription alloc] init] autorelease];

    [quantity setName:kShoppingItemQuantity];
    [quantity setAttributeType:NSStringAttributeType];
    [quantity setOptional:YES];
    [quantity setDefaultValue:@""];

    NSAttributeDescription *order =
            [[[NSAttributeDescription alloc] init] autorelease];

    [order setName:kShoppingItemOrder];
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

    [*listEntity setName:kShoppingListEntity];
    [*listEntity setManagedObjectClassName:kShoppingListClass];
    [*itemEntity setName:kShoppingItemEntity];
    [*itemEntity setManagedObjectClassName:kShoppingItemClass];

    NSRelationshipDescription *items =
            [[[NSRelationshipDescription alloc] init] autorelease];
    NSRelationshipDescription *list =
            [[[NSRelationshipDescription alloc] init] autorelease];

    // To-many relationship to ShoppingItem from ShoppingList
    [items setName:kShoppingListItems];
    [items setDestinationEntity:*itemEntity];
    [items setInverseRelationship:list];
    [items setOptional:NO];
    [items setMaxCount:-1]; // to-many relationship
    [items setMinCount:0];
    [items setDeleteRule:NSCascadeDeleteRule];
    // Foreign key to ShoppingList from ShoppingItem
    [list setName:kShoppingItemList];
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
