@class NSObject;
@class UIWindow;
@class UIViewController;
@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSDateFormatter;
@protocol UIApplicationDelegate;

@interface AppDelegate: NSObject <UIApplicationDelegate>
{
    UIWindow *_window;
    UIViewController *_rootViewController;
    // CoreData
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
    NSPersistentStoreCoordinator *_coordinator;
    // Defaults
    NSDateFormatter *_dateFormatter;
}
@property (nonatomic, retain) UIViewController *rootViewController;
@end

@interface AppDelegate (CoreData)

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

- (void)saveContext;
@end

@interface AppDelegate (Defaults)

@property (nonatomic, readonly) NSDateFormatter *dateFormatter;
@end
