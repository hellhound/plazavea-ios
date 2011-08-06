#import "Common/Views/EditableTableViewCell.h"
#import "Common/Controllers/EditableTableViewController.h"

@class NSIndexPath;
@class NSManagedObject;
@class UITextField;
@protocol UITextFieldDelegate;

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
