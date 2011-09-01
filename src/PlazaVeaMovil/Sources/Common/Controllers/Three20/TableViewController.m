#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Controllers/Constants.h"
#import "Common/Controllers/Three20/TableViewController.h"

@interface TableViewController (Private)

- (void)showToolbar:(NSNumber *)animated;
- (void)hideToolbar:(NSNumber *)animated;
@end

@implementation TableViewController

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self toolbarItems] == nil) {
        [self performSelector:@selector(hideToolbar:)
                withObject:[NSNumber numberWithBool:animated]
                afterDelay:kTableViewControllerToolbarDelay];
    } else if ([[self navigationController] isToolbarHidden]) {
        [self performSelector:@selector(showToolbar:)
                withObject:[NSNumber numberWithBool:animated]
                afterDelay:kTableViewControllerToolbarDelay];
    }
}

#pragma mark -
#pragma mark TableViewController (Private)

- (void)showToolbar:(NSNumber *)animated
{
    [[self navigationController] setToolbarHidden:NO
            animated:[animated boolValue]];
}

- (void)hideToolbar:(NSNumber *)animated
{
    [[self navigationController] setToolbarHidden:YES
            animated:[animated boolValue]];
}
@end
