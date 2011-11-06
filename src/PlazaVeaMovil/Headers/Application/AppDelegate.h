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
// Unfortunately we have to declare the property window to work on pre-iOS 5
// devices because theres a new property window on <UIApplicationDelegate> in
// SDK 5.0
@property (nonatomic, retain) UIWindow *window;
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
