#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "Common/Additions/NSString+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
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
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyCategoryName
                ascending:YES] autorelease]];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kEmergencyCategoryEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        NSArray *csvPathFiles = [[NSBundle mainBundle]
                pathsForResourcesOfType:@"csv" inDirectory:nil];
        NSString *filepath = [csvPathFiles objectAtIndex:0];
        NSString *csvString = [NSString stringWithContentsOfFile:filepath
                encoding:NSUTF8StringEncoding error:nil];
        NSArray *pasredCSV = [csvString getParsedRows];
        NSLog(@"%@", pasredCSV);
    }
    return self;
}

#pragma mark -
#pragma mark EmergencyCategoryController

@synthesize emergencyCategory = _emergencyCategory;

@end
