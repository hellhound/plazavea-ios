#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/Constants.h"
#import "ShoppingList/ShoppingListController.h"

@implementation ShoppingListController

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // TODO We should use titleView instead of title in the navigationItem
    // Conf the title
    [navItem setTitle:NSLocalizedString(kShoppingListTitle, nil)];
    // Conf the edit button
    [navItem setRightBarButtonItem:[self editButtonItem]];

    // Conf the add-item button
    UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
            target:nil action:nil] autorelease];
    UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:nil] autorelease];

    [self setToolbarItems:[NSArray arrayWithObjects:spacerItem, addItem, nil]];
    // show the toolbar
    [[self navigationController] setToolbarHidden:NO];
    return navItem;
}

#pragma mark -
#pragma mark ShoppingListController
@end
