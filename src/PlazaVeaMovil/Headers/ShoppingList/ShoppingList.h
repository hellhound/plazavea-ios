#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ReorderingManagedModel.h"

@interface ShoppingList: NSManagedObject <ReorderingManagedModel>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *lastModificationDate;
@property (nonatomic, retain) NSSet *items;
@end

@interface ShoppingItem: NSManagedObject <ReorderingManagedModel>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSNumber *checked;
@property (nonatomic, retain) ShoppingList *list;
@end
