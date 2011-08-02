@class NSManagedObject;
@class NSString;
@class NSDate;
@class NSNumber;

@interface ShoppingList: NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *items;
@end

@interface ShoppingItem: NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *quantity;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) ShoppingList *list;
@end
