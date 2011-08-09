#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ShoppingList/Constants.h"
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

+ (id)shoppingListWithName:(NSString *)name
  resultsController:(NSFetchedResultsController *)resultsController
{
    ShoppingList *newList =
            [NSEntityDescription insertNewObjectForEntityForName:
                kShoppingListEntity
            inManagedObjectContext:[resultsController managedObjectContext]];
    NSInteger order = [(NSNumber *)[[resultsController fetchedObjects]
            valueForKeyPath:@"@max.order"] integerValue] + 1;

    [newList setName:name];
    [newList setOrder:[NSNumber numberWithInteger:order]];
    return newList;
}
@end

@implementation ShoppingItem

#pragma mark -
#pragma mark ShoppingItem

@dynamic name, quantity, order, checked, list;
@end
