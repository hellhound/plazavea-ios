#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/BaseMeatController.h"

@interface MeatListController: BaseMeatController
{
    UIBarButtonItem *_backButton;
}

- (void)popToNavigationWindow;
@end
