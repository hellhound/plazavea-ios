#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface RecipesTableViewDelegate : TTTableViewGroupedVarHeightDelegate
{
    BOOL _isMeat;
}
@property (nonatomic, assign) BOOL isMeat;
- (id)initWithController:(TTTableViewController*)controller isMeat:(BOOL)isMeat;
@end