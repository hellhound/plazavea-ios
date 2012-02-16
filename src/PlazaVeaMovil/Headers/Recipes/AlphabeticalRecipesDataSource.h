#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface AlphabeticalRecipesDataSource: TTSectionedDataSource
{
    kRecipeFromType _from;
}
@property (nonatomic, assign) kRecipeFromType from;

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithMeatId:(NSString *)meatId;
- (id)initWithWineId:(NSString *)wineId;
@end
