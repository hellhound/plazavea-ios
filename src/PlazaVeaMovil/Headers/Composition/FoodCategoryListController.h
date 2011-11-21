#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Composition/Models.h"

@interface FoodCategoryListController : EditableCellTableViewController
{
    UINavigationItem *_navItem;
    UIView *_headerView;
    UILabel *_titleLabel;
}

@end