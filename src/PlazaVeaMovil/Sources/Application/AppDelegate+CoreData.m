#import <stdlib.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSObject+Additions.h"
#import "Common/Additions/NSFileManager+Additions.h"
#import "Common/Additions/NSError+Additions.h"
#import "Common/Constants.h"
#import "Application/EntityDescription.h"
#import "Application/AppDelegate.h"

@implementation AppDelegate (CoreData)

#pragma mark -
#pragma mark AppDelegate (CoreData)

- (NSManagedObjectContext *)context
{
    if (_context != nil)
        return _context;
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:[self coordinator]];
    return _context;
}

- (NSManagedObjectModel *)model
{
    if (_model != nil)
        return _model;
    _model = [[NSManagedObjectModel alloc] init];
    // TODO should add entities to the model before returning
    // TODO should support manual migration in the non-so-distant future
    [self initializeModel];
    return _model;
}

- (NSPersistentStoreCoordinator *)coordinator
{
    if (_coordinator != nil)
        return _coordinator;

    NSURL *storeURL =
            [[[NSFileManager defaultManager] appSupportDirectory]
                URLByAppendingPathComponent:SQL_STORE_FILE];
    NSError *error = nil;
    
    _coordinator = [[NSPersistentStoreCoordinator alloc]
            initWithManagedObjectModel:[self model]];
    // Perform lightweight migration
    // TODO should support manual migration in the non-so-distant future
    NSDictionary *options =
            [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithBool:YES],
                NSMigratePersistentStoresAutomaticallyOption,
                [NSNumber numberWithBool:YES],
                NSInferMappingModelAutomaticallyOption,
                nil];

    if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType
            configuration:nil URL:storeURL options:options error:&error]) {
        // Something shitty just happened, abort, abort, abort!
        [error log];
        // TODO should present a nice UIViewAlert informing the error
        abort();
    }
    return _coordinator;
}

- (void)saveContext
{
    NSManagedObjectContext *context = [self context];
    NSError *error = nil;

    if (context != nil && [context hasChanges] && ![context save:&error]) {
        // Something shitty just happened, abort, abort, abort!
        [error log];
        // TODO should present a nice UIViewAlert informing the error
        abort();
    }
}

- (void)initializeModel
{
    NSSet *classes = [NSObject setWithClassesConformingToProtocol:
            @protocol(EntityDescription)];
    NSMutableSet *allEntities = [NSMutableSet set];
    NSMutableDictionary *allLocalizations = [NSMutableDictionary dictionary];

    for (Class<EntityDescription> class in classes) {
        NSSet *entities = nil;
        NSDictionary *localizationDictionary = nil;

        [class createEntities:&entities
                localizationDictionary:&localizationDictionary];
        [allEntities unionSet:entities];
        [allLocalizations addEntriesFromDictionary:localizationDictionary];
    }

    NSManagedObjectModel *model = [self model];

    [model setEntities:[allEntities allObjects]];
    [model setLocalizationDictionary:allLocalizations];
}
@end
