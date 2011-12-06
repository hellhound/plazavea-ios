#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Emergency/Models.h"

@interface EmergencyCategoryController : EditableCellTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate>
{
    UINavigationItem *_navItem;
    NSFetchedResultsController *_filteredController;
    UISearchDisplayController *_searchController;
    UIView *_headerView;
    UILabel *_titleLabel;
}

@end
