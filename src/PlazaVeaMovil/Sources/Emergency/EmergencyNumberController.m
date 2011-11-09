#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Constants.h"
#import "Common/Additions/NSNull+Additions.h"
#import "Common/Controllers/EditableCellTableViewController.h"
#import "Common/Views/EditableTableViewCell.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Application/AppDelegate.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"
#import "Emergency/EmergencyNumberController.h"

static NSPredicate *kEmergencyNumbersPredicateTemplate;
static NSString *const kEmergencyNumberVariableKey = @"EMERGENCY_NUMBER";

@interface EmergencyNumberController (Private)

+ (void)initializePredicateTemplates;
@end

@implementation EmergencyNumberController

#pragma mark -
#pragma mark NSObject

+ (void)initialize
{
    if (self == [EmergencyNumberController class])
        [self initializePredicateTemplates];
}

- (void)dealloc
{
    [_emergencyCategory release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    [navItem setRightBarButtonItem:nil];
    return navItem;
}

#pragma mark -
#pragma mark EmergencyNumberController (Private)

+ (void)initializePredicateTemplates
{
    NSExpression *lhs =
            [NSExpression expressionForKeyPath:kEmergencyNumberCategory];
    NSExpression *rhs =
            [NSExpression expressionForVariable:kEmergencyNumberVariableKey];

    kEmergencyNumbersPredicateTemplate = [[NSComparisonPredicate
            predicateWithLeftExpression:lhs
            rightExpression:rhs
            modifier:NSDirectPredicateModifier
            type:NSEqualToPredicateOperatorType
            options:0] retain];
}
#pragma mark -
#pragma mark EmergencyNumberController (Public)

@synthesize emergencyCategory = _emergencyCategory;

- (id)initWithCategory:(EmergencyCategory *)emergencyCategory;
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:
            [[[NSSortDescriptor alloc] initWithKey:kEmergencyNumberName
                ascending:YES] autorelease]];
    NSManagedObjectContext *context = [(AppDelegate *)
            [[UIApplication sharedApplication] delegate] context];

    NSPredicate *predicate = [kEmergencyNumbersPredicateTemplate 
            predicateWithSubstitutionVariables:
                [NSDictionary dictionaryWithObject:
                    [NSNull nullOrObject:emergencyCategory]
                forKey:kEmergencyNumberVariableKey]];

    if ((self = [super initWithStyle:UITableViewStylePlain
            entityName:kEmergencyNumberEntity predicate:predicate
            sortDescriptors:sortDescriptors inContext:context]) != nil) {
        //TODO:load title and other stuff
        [self setEmergencyCategory:emergencyCategory];
        [self setCellStyle:UITableViewCellStyleSubtitle];
    }
    return self;
}


- (void)didCreateCell:(EditableTableViewCell *)cell
            forObject:(NSManagedObject *)object
          atIndexPath:(NSIndexPath *)indexPath
{
    EmergencyNumber *emergencyNumber = (EmergencyNumber *)object;

    [[cell textLabel] setText:[emergencyNumber name]];
    [[cell detailTextLabel] setText:[emergencyNumber phone]];
}

#pragma mark -
#pragma mark EditableTableViewController (Overridable)

- (UITableViewCell *)cellForObject:
        (NSManagedObject *)object
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

- (void)didSelectRowForObject:(EmergencyNumber *)emergencyNumber
                  atIndexPath:(NSIndexPath *)indexPath
{
    if (![self isEditing]){
        NSCharacterSet *characterSet = 
            [NSCharacterSet characterSetWithCharactersInString:@" -"];
        NSString *phoneNumber = [[[emergencyNumber phone]
                componentsSeparatedByCharactersInSet:characterSet]
                componentsJoinedByString: @""];
        NSString *formatedNumber =
                [NSString stringWithFormat:@"tel://%@", phoneNumber];
        [[UIApplication sharedApplication]
                openURL:[NSURL URLWithString:formatedNumber]];
    }
}
@end
