#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
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
        if ([csvPathFiles count] > 0){
            NSString *csvFilePath = [csvPathFiles objectAtIndex:0];
            [self loadCSV:csvFilePath];
            //comparo el nombre con el original
            //si no hay o es diferente cargo
            NSLog(@"yahoo");
        }
    }
    return self;
}

#pragma mark -
#pragma mark EmergencyCategoryController

@synthesize emergencyCategory = _emergencyCategory;

- (void)loadCSV:(NSString *)csvFilePath
{
    //TODO fix
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyCategoryName
                ascending:YES] autorelease]];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

    [request setEntity:[EmergencyFile entity]];
    [request setPredicate:nil];
    [request setSortDescriptors:sortDescriptors];

    NSFetchedResultsController *resultsController = 
        [[NSFetchedResultsController alloc]
            initWithFetchRequest:request
            managedObjectContext:_context
            sectionNameKeyPath:nil
            cacheName:nil];
    NSError *fetchError = nil;

    [resultsController performFetch:&fetchError];
    if ([[resultsController fetchedObjects] count] == 0){
        EmergencyFile *emergencyFile = [EmergencyFile fileWithName:csvFilePath
                context:_context];
        [self saveContext];
    }
    NSLog(@"%@", [[resultsController fetchedObjects] objectAtIndex:0]);

    NSString *csvString = [NSString stringWithContentsOfFile:csvFilePath
            encoding:NSUTF8StringEncoding error:nil];
    NSArray *pasredCSV = [csvString getParsedRows];
    //NSLog(@"%@", pasredCSV);
}
@end
