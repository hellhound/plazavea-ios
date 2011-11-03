#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "Common/Additions/NSString+Additions.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyCategoryController.h"

@implementation EmergencyCategoryController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_emergencyCategory release];
    [super dealloc];
}

- (id)init
{
    if ((self = [super init]) != nil) {
        
    }
    return self;
}

#pragma mark -
#pragma mark EmergencyCategoryController

@synthesize emergencyCategory = _emergencyCategory;

@end
