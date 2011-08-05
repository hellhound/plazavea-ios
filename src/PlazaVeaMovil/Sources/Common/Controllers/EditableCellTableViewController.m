#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableCellTableViewController.h"

@implementation EditableCellTableViewController

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (Class)cellClassForObject:(NSManagedObject *)object
                atIndexPath:(NSIndexPath *)indexPath;
{
    return [EditableTableViewCell class];
}

- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(UITableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil)
        cell = [[[EditableTableViewCell alloc]
                initWithStyle:_cellStyle
                reuseIdentifier:reuseIdentifier] autorelease];
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
        _cellStyle = UITableViewCellStyleDefault;
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
@end
