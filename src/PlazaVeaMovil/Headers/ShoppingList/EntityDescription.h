#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Application/EntityDescription.h"

@interface EntityDescription: NSObject <EntityDescription>

+ (NSArray *)attributeDescriptionsForShoppingList;
+ (NSArray *)attributeDescriptionsForShoppingItem;
+ (void)createShoppingListEntity:(NSEntityDescription **)listEntity
                  withAttributes:(NSArray *)attributes
                   andItemEntity:(NSEntityDescription **)itemEntity
                  withAttributes:(NSArray *)attributes;
@end
