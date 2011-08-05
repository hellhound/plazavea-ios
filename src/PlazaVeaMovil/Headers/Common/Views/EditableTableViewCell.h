@class UITableViewCell;
@class UITextField;

@interface EditableTableViewCell: UITableViewCell
{
    UITextField *_textField;
}
@property (nonatomic, retain) UITextField *textField;
@end
