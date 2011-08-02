#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/ShoppingList.h"

@interface ShoppingList ()

//@private
@property (nonatomic, retain) NSDate *primitiveLastModificationDate;
@end

@implementation ShoppingList

#pragma mark -
#pragma mark NSManagedObject

- (void)willSave
{
    if (![self isDeleted])
        // Using primitives inside willSave avoids infinite recursion
        [self setPrimitiveLastModificationDate:[NSDate date]];
}

#pragma mark -
#pragma mark ShoppingList

// primitives
@dynamic primitiveLastModificationDate;
// KVO properties
@dynamic name, lastModificationDate, order, items;
@end

@implementation ShoppingItem

#pragma mark -
#pragma mark ShoppingItem

@dynamic name, quantity, order, list;
@end
