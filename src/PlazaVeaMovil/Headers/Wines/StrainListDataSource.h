#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"

@interface StrainListDataSource: TTListDataSource
{
    NSString *_from;
}
@property (nonatomic, retain) NSString *from;
- (id)initWithRecipeId:(NSString *)recipeId;
@end