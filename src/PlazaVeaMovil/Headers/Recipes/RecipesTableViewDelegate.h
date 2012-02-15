#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"

@interface RecipesTableViewDelegate : TTTableViewGroupedVarHeightDelegate
{
    kRecipeFromType _from;
}
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithController:(TTTableViewController *)controller
                    from:(kRecipeFromType)from;
@end