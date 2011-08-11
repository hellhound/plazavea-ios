#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Additions)

- (void)save;
- (NSArray *)executeFetchRequest:(NSFetchRequest *)request;
@end
