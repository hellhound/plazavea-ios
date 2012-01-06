#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Common/Controllers/Three20/ReconnectableTableViewController.h"

@interface StrainListController: ReconnectableTableViewController
{
    NSString *_recipeId;
}
@property (nonatomic, retain) NSString *recipeId;

- (id)initWithRecipeId:(NSString *)recipeId;
@end