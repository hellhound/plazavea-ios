#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

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
