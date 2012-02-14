#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"

@interface RecipesTableViewDelegate : TTTableViewGroupedVarHeightDelegate
{
    BOOL _isMeat;
    kRecipeFromType _from;
}
@property (nonatomic, assign) BOOL isMeat;
@property (nonatomic, assign) kRecipeFromType from;
- (id)initWithController:(TTTableViewController *)controller
                  isMeat:(BOOL)isMeat;
- (id)initWithController:(TTTableViewController *)controller
                    from:(kRecipeFromType)from;
@end