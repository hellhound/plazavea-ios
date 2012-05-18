#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <Three20/Three20.h>
#import <TSAlertView/TSAlertView.h>
#import "FBConnect.h"
#import "SA_OAuthTwitterEngine.h"

@interface AppDelegate: NSObject <UIApplicationDelegate, TTNavigatorDelegate,
        SA_OAuthTwitterEngineDelegate, FBSessionDelegate, TSAlertViewDelegate,
            NSURLConnectionDelegate>
{
    UIWindow *_window;
    UIWindow *_overlay;
    // CoreData
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
    NSPersistentStoreCoordinator *_coordinator;
    // Defaults
    NSDateFormatter *_dateFormatter;
    Facebook *_facebook;
    SA_OAuthTwitterEngine *_twitter;
    NSMutableData *_receivedData;
}
// Unfortunately we have to declare the property window to work on pre-iOS 5
// devices because theres a new property window on <UIApplicationDelegate> in
// SDK 5.0
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) SA_OAuthTwitterEngine *twitter;
@property (nonatomic, retain) NSMutableData *receivedData;
- (NSString *)getUUID;
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
