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

@interface Diagnosis: NSObject
{
    Profile *_profile;
    NSString *_weightRange;
    NSNumber *_bodyMassIndex;
    NSString *_result;
    NSNumber *_metabolicBasalRate;
    NSNumber *_activityFactor;
    NSNumber *_requieredEnergy;
    NSNumber *_energyConsumption;
    NSNumber *_time;
    
}
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, readonly) NSString *weightRange;
@property (nonatomic, readonly) NSNumber *bodyMassIndex;
@property (nonatomic, readonly) NSString *result;
@property (nonatomic, readonly) NSNumber *metabolicBasalRate;
@property (nonatomic, readonly) NSNumber *activityFactor;
@property (nonatomic, readonly) NSNumber *requieredEnergy;
@property (nonatomic, readonly) NSNumber *energyConsumption;
@property (nonatomic, readonly) NSNumber *time;
@end