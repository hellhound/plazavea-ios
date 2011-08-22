#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <Three20/Three20.h>

@interface AppDelegate: NSObject <UIApplicationDelegate, TTNavigatorDelegate>
{
    UIWindow *_window;
    // CoreData
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
    NSPersistentStoreCoordinator *_coordinator;
    // Defaults
    NSDateFormatter *_dateFormatter;
}
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
