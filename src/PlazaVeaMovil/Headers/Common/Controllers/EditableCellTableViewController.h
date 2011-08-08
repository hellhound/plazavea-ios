#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Views/EditableTableViewCell.h"
#import "Common/Controllers/EditableTableViewController.h"

@interface EditableCellTableViewController: EditableTableViewController
    <UITextFieldDelegate>
{
    UITableViewCellStyle _cellStyle;
    UITextField *_activeTextField;
}
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@end

@interface EditableCellTableViewController (Overridable)

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath;
- (void)didChangeObject:(NSManagedObject *)object value:(NSString *)value;
@end
