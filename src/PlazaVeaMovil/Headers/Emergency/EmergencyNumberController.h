#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/EditableCellTableViewController.h"
#import "Emergency/Models.h"

@interface EmergencyNumberController : EditableCellTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate>
{
    UINavigationItem *_navItem;
    NSFetchedResultsController *_filteredController;
    UISearchDisplayController *_searchController;
    EmergencyCategory *_emergencyCategory;
}
@property (nonatomic, retain) EmergencyCategory *emergencyCategory;

- (id)initWithCategory:(EmergencyCategory *)emergencyCategory;
@end
