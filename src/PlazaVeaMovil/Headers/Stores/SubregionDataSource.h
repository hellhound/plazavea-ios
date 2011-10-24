#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@interface SubregionDataSource: TTListDataSource
{
    NSString *_regionId;
}
@property (nonatomic, retain) NSString *regionId;

- (id)initWithRegionId:(NSString *)regionId;
@end