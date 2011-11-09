#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyCategoryController.h"

@implementation EmergencyCategoryController

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyCategoryName
                ascending:YES] autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kEmergencyCategoryEntity predicate:nil
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [EmergencyFile loadFromCSVinContext:context];
        [self setTitle:NSLocalizedString(kEmergencyCategoryTitle, nil)];
    }
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    [navItem setRightBarButtonItem:nil];
    return navItem;
}

#pragma mark -
#pragma mark EmergencyCategoryController

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    EmergencyCategory *category = (EmergencyCategory *)object;

    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    [[cell textLabel] setText:[category name]];
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:
        (NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(EditableTableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil)
        cell = [[[EditableTableViewCell alloc]
                initWithStyle:_cellStyle
                reuseIdentifier:reuseIdentifier] autorelease];
    return cell;
}
@end
