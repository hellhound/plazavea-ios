#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ReorderingManagedObject.h"
#import "Common/Controllers/EditableCellTableViewController.h"

@implementation EditableCellTableViewController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    _activeTextField = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    // The following lines fix a horrible bug that makes the keyboard persistent
    // between editing and read-only sessions of the table view
    [_activeTextField resignFirstResponder]; // could be nil but meh
    [self resignFirstResponder]; // just in case :P
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (Class)cellClassForObject:(NSManagedObject *)object
                atIndexPath:(NSIndexPath *)indexPath;
{
    return [EditableTableViewCell class];
}

- (UITableViewCell *)cellForObject:
        (NSManagedObject<ReorderingManagedObject> *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(EditableTableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil)
        cell = [[[EditableTableViewCell alloc]
                initWithStyle:_cellStyle
                reuseIdentifier:reuseIdentifier] autorelease];
    
    UITextField *textField = [cell textField];

    [textField setTag:[[object order] integerValue]];
    [textField setDelegate:self];
    [self didCreateCell:(EditableTableViewCell *)cell forObject:object
            atIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark EditableCellTableViewController (Public)

@synthesize cellStyle = _cellStyle;

- (id)initWithStyle:(UITableViewStyle)style
         entityName:(NSString *)entityName
          predicate:(NSPredicate *)predicate
    sortDescriptors:(NSArray *)sortDescriptors
          inContext:(NSManagedObjectContext *)context
{
    if ((self = [super initWithStyle:style entityName:entityName
            predicate:predicate sortDescriptors:sortDescriptors
            inContext:context]) != nil)
        [self setCellStyle:UITableViewCellStyleDefault];
    return self;
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    // NO-OP
}

- (void)didChangeObject:(NSManagedObject *)object value:(NSString *)value
{
    // NO-OP
}
@end
