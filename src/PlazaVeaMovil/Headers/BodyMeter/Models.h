#import <Foundation/Foundation.h>

@interface Profile: NSObject
{
    NSNumber *_age;
    kBodyMeterGenderType _gender;
    NSNumber *_height;
    NSNumber *_weight;
    kBodyMeterActivityType _activity;
}
@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, assign) kBodyMeterGenderType gender;
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSNumber *weight;
@property (nonatomic, assign) kBodyMeterActivityType activity;
@end