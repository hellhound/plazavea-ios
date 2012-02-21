#import <stdlib.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSError+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"

@implementation NSManagedObjectContext (Additions)

#pragma mark -
#pragma mark NSManagedObjectContext (Additions)

- (void)save
{
    NSError *error = nil;

    if ([self hasChanges] && ![self save:&error]) {
        // Something shitty just happened, abort, abort, abort!
        [error log];
        // TODO should present a nice UIViewAlert informing the error
        abort();
    }
}

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request
{
    NSError *error = nil;
    NSArray *objects = [self executeFetchRequest:request error:&error];

    if (objects == nil) {
        [error log];
        abort();
    }
    return objects;
}
@end
