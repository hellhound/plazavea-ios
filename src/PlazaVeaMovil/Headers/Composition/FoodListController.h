#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Composition/Models.h"

@interface FoodListController : EditableCellTableViewController
        <UISearchBarDelegate, UISearchDisplayDelegate>
{
    UINavigationItem *_navItem;
    NSFetchedResultsController *_filteredController;
    UISearchDisplayController *_searchController;
    FoodCategory *_foodCategory;
    UIView *_headerView;
    UILabel *_titleLabel;
}
@property (nonatomic, retain) FoodCategory *foodCategory;

- (id)initWithCategory:(FoodCategory *)foodCategory;
@end