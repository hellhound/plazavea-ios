#import <UIKit/UIKit.h>

@interface EditableTableViewCell: UITableViewCell
{
    UITextField *_textField;
}
@property (nonatomic, retain) UITextField *textField;
@end
