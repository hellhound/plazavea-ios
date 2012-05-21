#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <TSAlertView/TSAlertView.h>

#import "Common/Constants.h"
#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Application/Constants.h"
#import "Application/AppDelegate.h"
#import "ShoppingList/Constants.h"
#import "ShoppingList/Models.h"
#import "ShoppingList/TSAlertView+NewShoppingListAlertView.h"
#import "ShoppingList/ShoppingListController.h"
#import "ShoppingList/ShoppingListsController.h"

static CGFloat margin = 5.;
static CGFloat disclousureWidth = 20.;
static CGFloat headerHeight = 40.;

@interface ShoppingListsController ()

@property (nonatomic, assign) BOOL noLists;
- (void)postEventWithType:(NSString *)type;
@end

@implementation ShoppingListsController

@synthesize noLists;

#pragma mark -
#pragma mark NSObject

- (id)init
{
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:
            kShoppingHistoryEntryName ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kShoppingListEntity predicate:nil
                sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kShoppingListTitle, nil)];
        [self setAllowsMovableCells:YES];
        //[self setCellStyle:UITableViewCellStyleSubtitle];
        noLists = YES;
    }
    return self;
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];

    // Conf the toolbars
    if ([self toolbarItems] == nil) {
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                    target:nil action:NULL] autorelease];
        // Conf the add-item button
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(barButtonAddIcon)]){
            UIImage *buttonImage = (UIImage *)TTSTYLE(barButtonAddIcon);
            [addButton setImage:buttonImage forState:UIControlStateNormal];
            [addButton setFrame:CGRectMake(0.0, 0.0, buttonImage.size.width, 
                    buttonImage.size.height)];
        }
        [addButton addTarget:self action:@selector(addShoppingListHandler:)
                forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *addItem = [[[UIBarButtonItem alloc]
                initWithCustomView:addButton] autorelease];
        NSArray *toolbarItems =
                [NSArray arrayWithObjects:spacerItem, addItem, nil];

        [[self readonlyToolbarItems] addObjectsFromArray:toolbarItems];
        [[self editingToolbarItems] addObjectsFromArray:toolbarItems];
        [self setToolbarItems:[self readonlyToolbarItems]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = [[self tableView] bounds];
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(.0, .0,
            bounds.size.width, (headerHeight + kShoppingListsBannerHeight))]
                autorelease];

    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(shopingListBackgroundHeader)]){
        UIImageView *backgroundView = [[[UIImageView alloc] 
                initWithImage:(UIImage *)TTSTYLE(shopingListBackgroundHeader)]
                    autorelease];

        [headerView setClipsToBounds:YES];
        [headerView addSubview:backgroundView];
        [headerView sendSubviewToBack:backgroundView];
    }
    UIImageView *imageView =[[[UIImageView alloc] initWithFrame:
            CGRectMake(.0, headerHeight, kShoppingListsBannerWidth,
                kShoppingListsBannerHeight)] autorelease];
    
    [imageView setImage:[UIImage imageNamed:kShoppingListsDefaultBanner]];
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];

    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0., 10.,
            bounds.size.width, 20.)] autorelease];

    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setNumberOfLines:1];
    [titleLabel setMinimumFontSize:10];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:NSLocalizedString(kShoppingListTitle, nil)];

    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet 
            hasStyleSheetForSelector:@selector(headerColorYellow)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];

    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    [[self tableView] setTableHeaderView:headerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (void)didSelectRowForObject:(ShoppingList *)shoppingList
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing])
        [[self navigationController]
                pushViewController:
                    [[[ShoppingListController alloc]
                        initWithShoppingList:shoppingList
                        delegate:self] autorelease]
                animated:YES];
}

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    ShoppingList *list = (ShoppingList *)object;
    //NSDateFormatter *dateFormatter = [(AppDelegate *)
    //        [[UIApplication sharedApplication] delegate] dateFormatter];
    //NSDate *date = [list lastModificationDate];

    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:[list name]];
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:18.]];
    [[cell textLabel] setNumberOfLines:0];
    [[cell detailTextLabel] setText:nil];
    //[[cell detailTextLabel] setText:date == nil ||
    //        [date isEqual:[NSNull null]] ?
    //        kShoppingListDefaultDetailText :
    //        [dateFormatter stringFromDate:date]];
}

#pragma mark -
#pragma mark EditableCellTableViewController (Overridable)

- (void)didChangeObject:(ShoppingList *)list value:(NSString *)value
{
    [list setName:value];
}

#pragma mark -
#pragma mark ShoppingListsController (Public)

@synthesize receivedData = _receivedData;

- (void)addShoppingList:(NSString *)name
{
    [ShoppingList shoppingListWithName:name
            resultsController:[self resultsController]];
    [self fetchUpdateAndReload];
    [self scrollToTop];
}

#pragma mark -
#pragma mark ShoppingListsController (Private)

- (void)postEventWithType:(NSString *)type
{
    NSURL *url = [NSURL URLWithString:EVENTENDPOINT(@"/appevents/")];
    NSMutableURLRequest *request = [NSMutableURLRequest
            requestWithURL:url
                cachePolicy:NSURLRequestUseProtocolCachePolicy
                timeoutInterval:60.];
    
    [request setHTTPMethod:kPostHTTPMethod];
    [request setValue:kContentHTTPHeaderValue
            forHTTPHeaderField:kContentHTTPHeaderKey];
    
    NSString *UUID = [(AppDelegate *)[[UIApplication sharedApplication]
            delegate] getUUID];
    NSString *postString = [NSString stringWithFormat:
            kAppEventRequestString,
                kTypeResquestKey, type,
                kDeviceIdRequestKey, UUID,
                kMetadataRequestKey, nil];
    
    [request setHTTPBody:[postString dataUsingEncoding:
            NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[[NSURLConnection alloc]
            initWithRequest:request delegate:self] autorelease];
    
    if (connection) {
        _receivedData = [[NSMutableData data] retain];
    }
}

#pragma mark -
#pragma mark ShoppingListsController (EnventHandler)

- (void)addShoppingListHandler:(UIControl *)control
{
    if ([self isEditing]) {
        TSAlertView *alertView = [TSAlertView alertViewForNewShoppingList:self
                fromActionSheet:NO];

        [alertView show];
    } else {
        [[self navigationController]
                pushViewController:[[[ShoppingListController alloc]
                    initWithShoppingList:nil
                    delegate:self] autorelease] animated:YES];
    }
}

#pragma mark -
#pragma mark <ShoppingListControllerDelegate>

- (ShoppingList *)shoppingListController:
    (ShoppingListController *)shoppingListController
              didAddShoppingListWithName:(NSString *)name
{
    ShoppingList *list = [ShoppingList shoppingListWithName:name
        resultsController:[self resultsController]];

    // First, save the context
    [self saveContext];
    [self fetchUpdateAndReload];
    [self postEventWithType:@"add"];
    return list;
}

- (void)shoppingListController:(ShoppingListController *)shoppingListController
         didDeleteShoppingList:(ShoppingList *)shoppingList
{
    [self fetchUpdateAndReload];
    [self postEventWithType:@"delete"];
}

- (void)shoppingListController:(ShoppingListController *)shoppingListController
          didCloneShoppingList:(ShoppingList *)shoppingList
{
    [shoppingList setName:[ShoppingList resolveNewNameFromName:[
            shoppingList name]]];
    [self fetchUpdateAndReload];
    [self postEventWithType:@"add"];
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows =
            [super tableView:tableView numberOfRowsInSection:section];
    
    if (numberOfRows == 0 && !noLists) {
        TSAlertView *alertView = [[[TSAlertView alloc]
                initWithTitle:kShoppingListsAlertTitle
                    message:kShoppingListsAlertMessage delegate:self
                    cancelButtonTitle:kShoppingListsAlertCancel
                    otherButtonTitles:kShoppingListsAlertCreate, nil]
                    autorelease];
        
        [alertView show];
        noLists = NO;
    }
    return numberOfRows;
}

#pragma mark -
#pragma mark <UITableViewDelegate>

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat accessoryWidth = disclousureWidth;
    NSString *label = [(ShoppingList *)[_resultsController
            objectAtIndexPath:indexPath] name];    
    CGSize constrainedSize = [tableView frame].size;
    constrainedSize.width -= (margin * 4) + accessoryWidth;
    CGFloat cellHeight = [label sizeWithFont:[UIFont boldSystemFontOfSize:18.]
            constrainedToSize:constrainedSize
                lineBreakMode:UILineBreakModeWordWrap].height + (margin * 4);
    
    return cellHeight;
}


#pragma mark -
#pragma mark <NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *response = [[[NSString alloc] initWithData:_receivedData
            encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"%@", response);
    [_receivedData release];
}
@end
