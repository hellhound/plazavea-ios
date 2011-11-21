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

static NSPredicate *kFoodsPredicateTemplate;
static NSString *const kFoodVariableKey = @"FOOD";

@interface FoodDetailController (Private)

+ (void)initializePredicateTemplates;
@end

@implementation FoodDetailController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [FoodDetailController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    [_food release];
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
#pragma mark FoodistController (Public)

@synthesize food = _food;

- (id)initWithFood:(Food *)food;
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kFoodName ascending:YES]
                autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];
    
    NSPredicate *predicate = [kFoodsPredicateTemplate 
            predicateWithSubstitutionVariables: [NSDictionary
                dictionaryWithObject:[NSNull nullOrObject:food]
                forKey:kFoodVariableKey]];
    
    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kFoodEntity predicate:predicate
                sortDescriptors:sortDescriptors inContext:context]) != nil) {
        [self setTitle:NSLocalizedString(kFoodDetailTitle, nil)];
        [self setFood:food];
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
@end