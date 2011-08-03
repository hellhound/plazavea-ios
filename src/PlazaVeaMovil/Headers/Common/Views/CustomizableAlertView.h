@class UIAlertView;

@interface CustomizableAlertView: UIAlertView
{
    UIView *_customSubview;
}
@property (nonatomic, retain) UIView *customSubview;
@end
