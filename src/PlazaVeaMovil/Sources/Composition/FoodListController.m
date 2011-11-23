#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Composition/Constants.h"
#import "Composition/Models.h"
#import "Composition/FoodDetailController.h"
#import "Composition/FoodListController.h"

static NSPredicate *kFoodsPredicateTemplate;
static NSString *const kFoodVariableKey = @"FOOD";

@interface FoodListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@interface FoodListController (Private)

+ (void)initializePredicateTemplates;
@end

@implementation FoodListController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [FoodListController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    [_foodCategory release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    if (_navItem == nil){
        _navItem = [super navigationItem];
        [_navItem setRightBarButtonItem:nil];
    }
    return _navItem;
}

#pragma mark -
#pragma mark UIView

- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [self tableView];
    
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                         autorelease]];
    // Configuring the label
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
                         autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];    
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark FoodListController (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs = [NSExpression expressionForKeyPath:kFoodCategory];
    NSExpression *rhs = [NSExpression expressionForVariable:kFoodVariableKey];
    
    kFoodsPredicateTemplate = [[NSComparisonPredicate 
            predicateWithLeftExpression:lhs rightExpression:rhs
                modifier:NSDirectPredicateModifier type:
                NSEqualToPredicateOperatorType options:0] retain];
}

#pragma mark -
#pragma mark FoodListController (Public)

@synthesize foodCategory = _foodCategory, headerView = _headerView,
        titleLabel = _titleLabel;

- (id)initWithCategory:(FoodCategory *)foodCategory;
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kFoodName ascending:YES]
                autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    
    NSPredicate *predicate = [kFoodsPredicateTemplate 
            predicateWithSubstitutionVariables: [NSDictionary
                dictionaryWithObject:[NSNull nullOrObject:foodCategory]
                forKey:kFoodVariableKey]];
    
    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kFoodEntity predicate:predicate
                sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setFoodCategory:foodCategory];
        
        UITableView *tableView = [self tableView];

        NSString *title = [_foodCategory name];
        UIFont *font = [_titleLabel font];
        CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
        CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
        CGFloat titleHeight = [title sizeWithFont:font
                constrainedToSize:constrainedTitleSize
                    lineBreakMode:UILineBreakModeWordWrap].height;
        CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
        
        [_titleLabel setText:title];
        [_titleLabel setFrame:titleFrame];
        // Adding the subviews to the header view
        [_headerView addSubview:_titleLabel];
        
        CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
        CGRect headerFrame = CGRectMake(.0, .0, boundsWidth, titleHeight);
        
        [_headerView setFrame:headerFrame];
        [tableView setTableHeaderView:_headerView];
    }
    return self;
}

- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    Food *food = (Food *)object;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:[food name]];
}

#pragma mark -
#pragma mark <UITableViewDataSource>

- (BOOL)    tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:(NSManagedObject *)object
                     withCellClass:(Class)cellClass
                         reuseCell:(EditableTableViewCell *)cell
                   reuseIdentifier:(NSString *)reuseIdentifier
                       atIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil)
        cell = [[[EditableTableViewCell alloc]
                 initWithStyle:_cellStyle
                    reuseIdentifier:reuseIdentifier] autorelease];
    return cell;
}

- (void)didSelectRowForObject:(Food *)food
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing]) {
        [[self navigationController] pushViewController:
                [[[FoodDetailController alloc] initWithFood:food] autorelease]
                    animated:YES];
    }
}
@end