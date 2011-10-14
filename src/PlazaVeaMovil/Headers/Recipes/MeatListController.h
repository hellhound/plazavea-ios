#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Recipes/BaseMeatController.h"

@interface MeatListController: BaseMeatController
{
    UIBarButtonItem *_backButton;
}

- (void)popToNavigationWindow;
@end
