#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Views/InputView.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingList.h"
#import "ShoppingList/ShoppingListController.h"

@interface ShoppingListController (UIAlertViewDelegate)
@end

@implementation ShoppingListController (UIAlertViewDelegate)

#pragma mark -
#pragma mark <UIAlertViewDelegate>

- (void)            alertView:(InputView *)inputView
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [inputView cancelButtonIndex]) {
        NSManagedObjectContext *context = [_appDelegate context];
        ShoppingList *newList =
                [NSEntityDescription insertNewObjectForEntityForName:
                    kShoppingListEntity
                inManagedObjectContext:context];
        NSInteger order = [(NSNumber *)[[_resultsController fetchedObjects]
                valueForKeyPath:@"@max.order"] integerValue] + 1;

        [newList setName:[[inputView textField] text]];
        [newList setOrder:[NSNumber numberWithInteger:order]];
        [self performFetch];
        [[self tableView] reloadData];
        [self updateUndoRedo];
    }
}
@end
