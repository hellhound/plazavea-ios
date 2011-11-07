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
        }
    }
    return self;
}

#pragma mark -
#pragma mark EmergencyCategoryController

@synthesize emergencyCategory = _emergencyCategory;

- (void)loadCSV:(NSString *)csvFilePath
{
    NSArray *sortFileNameDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyFileName
                ascending:YES] autorelease]];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];

    [request setEntity:[EmergencyFile entity]];
    [request setPredicate:nil];
    [request setSortDescriptors:sortFileNameDescriptors];

    NSFetchedResultsController *resultsController = 
        [[[NSFetchedResultsController alloc]
            initWithFetchRequest:request
            managedObjectContext:_context
            sectionNameKeyPath:nil
            cacheName:nil] autorelease];
    NSError *fetchError = nil;

    [resultsController performFetch:&fetchError];
    if ([[resultsController fetchedObjects] count] == 0){
        [EmergencyFile fileWithName:csvFilePath context:_context];
        [self saveContext];
    }
//cut here
    EmergencyFile *emergencyFile = [[resultsController fetchedObjects]
        objectAtIndex:0];
    if (![[emergencyFile name] isEqualToString:csvFilePath]){
        [emergencyFile setName:csvFilePath];
        [self saveContext];
    } else {
        return;
    }
    NSString *csvString = [NSString stringWithContentsOfFile:csvFilePath
            encoding:NSUTF8StringEncoding error:nil];
    NSArray *pasredCSV = [csvString getParsedRows];
    //convert a parsedCSV in a diciotnary
    NSMutableDictionary *emergencyThree = [NSMutableDictionary dictionary];
    for (NSArray *parsedRow in pasredCSV){
        NSString *parsedRowCategory = [parsedRow objectAtIndex:0];
        NSMutableArray *parsedCollectionNumbers = [emergencyThree 
                objextForKey:parsedRowCategory]

        if (parsedCollectionNumbers == nil){
            [emergencyThree setObject:[NSMutableArray array] 
                    forKey:parsedRowCategory];
        }
        NSString *parsedName = [parsedRow objectAtIndex:1];
        NSString *parsedNumber = [parsedRow objectAtIndex:2];
        [parsedCollectionNumbers addObject:[NSDictionary 
                dictionaryWithObjectsAndKeys:parsedName, @"name", parsedNumber,
                @"number", nil];
    }
}
@end
