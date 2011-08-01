@class NSObject;
@class UIWindow;
@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@protocol UIApplicationDelegate;

@interface AppDelegate: NSObject <UIApplicationDelegate>
{
    UIWindow *_window;
    // CoreData
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
    NSPersistentStoreCoordinator *_coordinator;
}
@end

@interface AppDelegate (CoreData)

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

- (void)saveContext;
- (void)initializeModel;
@end
