#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/BasePromotionController.h"

@interface PromotionListController: BasePromotionController
{
    UIBarButtonItem *_backButton;
}

- (void)popToNavigationWindow;
@end
