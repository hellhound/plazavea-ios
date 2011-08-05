#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableTableViewController.h"

@interface EditableTableViewController (NSFetchedResultsControllerDelegate)
@end

@implementation EditableTableViewController (NSFetchedResultsControllerDelegate)

#pragma mark -
#pragma mark <NSFetchedResultsControllerDelegate>

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // NO-OP. This empty method is intentional. Implementing any delegate method
    // triggers the change-tracking functionality of the fetch-request
    // controller;
}
@end
