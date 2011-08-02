#import "Application/EntityDescription.h"

@class NSObject;
@class NSEntityDescription;
@class NSManagedObjectContext;

@interface EntityDescription: NSObject <EntityDescription>

+ (NSArray *)attributeDescriptionsForShoppingList;
+ (NSArray *)attributeDescriptionsForShoppingItem;
+ (void)createShoppingListEntity:(NSEntityDescription **)listEntity
                  withAttributes:(NSArray *)attributes
                   andItemEntity:(NSEntityDescription **)itemEntity
                  withAttributes:(NSArray *)attributes;
@end
