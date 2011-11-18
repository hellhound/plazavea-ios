#import <stdlib.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSObject+Additions.h"
#import "Common/Additions/NSURL+Additions.h"
#import "Common/Additions/NSFileManager+Additions.h"
#import "Common/Additions/NSError+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Models/ManagedObject.h"
#import "Emergency/Models.h"
#import "Composition/Models.h"
#import "Application/AppDelegate.h"

@interface AppDelegate (CoreDataPrivate)

- (void)initializeModel;
@end

@implementation AppDelegate (CoreData)

#pragma mark -
#pragma mark CoreDataPrivate

- (void)initializeModel
{
    NSSet *classes = [NSObject setWithClassesConformingToProtocol:
            @protocol(ManagedObject)];
    NSMutableSet *allEntities = [NSMutableSet set];
    NSMutableDictionary *allLocalizations = [NSMutableDictionary dictionary];
    NSManagedObjectContext *context = [self context];

    for (Class<ManagedObject> class in classes) {
        NSEntityDescription *entity = nil;
        NSDictionary *localizationDictionary = nil;

        [class createEntity:&entity
                localizationDictionary:&localizationDictionary context:context];
        // Coalesce all entities and all localizations
        [allEntities addObject:entity];
        [allLocalizations addEntriesFromDictionary:localizationDictionary];
    }
    _model = [[NSManagedObjectModel alloc] init];
    [_model setEntities:[allEntities allObjects]];
    if ([allLocalizations count] > 0)
        [_model setLocalizationDictionary:allLocalizations];
    //load the emergencynumbers from CSV
    [EmergencyFile loadFromCSVinContext:context];
    [FoodFile loadFromCSVinContext:context];
}

#pragma mark -
#pragma mark AppDelegate (CoreData)

- (NSManagedObjectContext *)context
{
    if (_context != nil)
        return _context;

    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:[self coordinator]];

    NSUndoManager *undoManager = [[[NSUndoManager alloc] init] autorelease];

    [undoManager setLevelsOfUndo:UNDO_LEVEL];
    [_context setUndoManager:undoManager];
    return _context;
}

- (NSManagedObjectModel *)model
{
    if (_model != nil)
        return _model;
    [self initializeModel];
    // TODO should support manual migration in the non-so-distant future
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
    [[self context] save];
}
@end
