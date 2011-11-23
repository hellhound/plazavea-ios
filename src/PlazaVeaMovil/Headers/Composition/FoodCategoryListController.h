#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Composition/Models.h"

@interface FoodCategoryListController : EditableCellTableViewController
<UISearchBarDelegate, UISearchDisplayDelegate>
{
    UINavigationItem *_navItem;
    NSFetchedResultsController *_filteredController;
    UISearchDisplayController *_searchController;
    UIView *_headerView;
    UILabel *_titleLabel;
}

@end