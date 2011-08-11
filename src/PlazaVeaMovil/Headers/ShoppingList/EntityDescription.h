#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"

@interface EntityDescription: NSObject <ManagedObject>

+ (NSArray *)attributeDescriptionsForShoppingList;
+ (NSArray *)attributeDescriptionsForShoppingItem;
+ (NSArray *)attributeDescriptionsForHistoryEntry;
+ (void)createShoppingListEntity:(NSEntityDescription **)listEntity
                  withAttributes:(NSArray *)listEntityAttributes
                   andItemEntity:(NSEntityDescription **)itemEntity
                  withAttributes:(NSArray *)itemEntityAttributes;
+ (void)createShoppingHistoryEntry:(NSEntityDescription **)entity
                    withAttributes:(NSArray *)attributes;
@end
