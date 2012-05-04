#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"

@interface StrainListDataSource: TTListDataSource
{
    NSString *_from;
    NSString *_recipeId;
}
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *recipeId;
- (id)initWithRecipeId:(NSString *)recipeId;
@end