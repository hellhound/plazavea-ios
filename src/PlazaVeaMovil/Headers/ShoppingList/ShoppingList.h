@class NSManagedObject;
@class NSString;
@class NSDate;
@class NSNumber;

@interface ShoppingList: NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSNumber *order;
@end
