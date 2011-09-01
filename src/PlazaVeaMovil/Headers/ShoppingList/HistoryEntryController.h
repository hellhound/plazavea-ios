#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Controllers/EditableTableViewController.h"
#import "ShoppingList/Models.h"

@class HistoryEntryController;

@protocol HistoryEntryControllerDelegate <NSObject>

@optional
// history entry can be nil; thus differentiating between an insert and a
// selection
// also withText can be nil, if with text and history entry are setted, the
// alert prefed history entry over withText
- (void)historyEntryController:(HistoryEntryController *)historyEntryController
                  historyEntry:(ShoppingHistoryEntry *)historyEntry
                      withText:(NSString *)productText;
@end

@interface HistoryEntryController: EditableTableViewController
    <UISearchBarDelegate, UISearchDisplayDelegate>
{
    id<HistoryEntryControllerDelegate> _delegate;
    NSFetchedResultsController *_filteredController;
    UISearchDisplayController *_searchController;
}
@property (nonatomic, assign) id<HistoryEntryControllerDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

+ (NSPredicate *)predicateForEntriesLikeName:(NSString *)name;
@end

@interface HistoryEntryController (EventHandler)

- (void)addHistoryEntry:(UIControl *)control;
@end
