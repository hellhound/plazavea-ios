#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/BasePromotionController.h"

@interface PromotionListController: BasePromotionController
{
    UIBarButtonItem *_backButton;
    UIView *_headerView;
    UILabel *_titleLabel;
}

- (void)popToNavigationWindow;
@end
