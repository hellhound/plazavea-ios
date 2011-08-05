#import "Common/Models/ReorderingManagedModel.h"

@class NSManagedObject;
@class NSString;
@class NSDate;
@class NSNumber;

@interface ShoppingList: NSManagedObject <ReorderingManagedModel>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSSet *items;
@end

@interface ShoppingItem: NSManagedObject <ReorderingManagedModel>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *quantity;
@property (nonatomic, retain) ShoppingList *list;
@end
