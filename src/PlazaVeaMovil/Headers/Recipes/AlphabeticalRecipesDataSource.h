#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface AlphabeticalRecipesDataSource: TTSectionedDataSource

- (id)initWithCategoryId:(NSString *)categoryId;
- (id)initWithMeatId:(NSString *)meatId;
- (id)initWithWineId:(NSString *)wineId;
@end
