#import <Foundation/Foundation.h>

@interface Profile: NSObject
{
    NSNumber *_age;
    kBodyMeterGenderType _gender;
    NSNumber *_height;
    NSNumber *_weight;
    kBodyMeterActivityType _activity;
    NSNumber *_idealWeight;
}
@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, assign) kBodyMeterGenderType gender;
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSNumber *weight;
@property (nonatomic, assign) kBodyMeterActivityType activity;
@property (nonatomic, retain) NSNumber *idealWeight;
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
- (id)initWithProfile:(Profile *)profile;
@end

@interface Meal: NSObject
{
    NSString *_name;
    NSNumber *_calories;
    NSNumber *_carbohidrates;
    NSNumber *_proteins;
    NSNumber *_fat;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *calories;
@property (nonatomic, readonly) NSNumber *carbohidrates;
@property (nonatomic, readonly) NSNumber *proteins;
@property (nonatomic, readonly) NSNumber *fat;
- (id)initWithName:(NSString *)name energyRequirement:(NSNumber *)energy;
@end

@interface Meals: NSObject
{
    NSArray *_meals;
    BOOL _snacks;
    NSNumber *_energy;
}
@property (nonatomic, readonly) NSArray *meals;
@property (nonatomic, retain) NSNumber *energy;
- (id)initWithEnergyRequirement:(NSNumber *)energy snacks:(BOOL)snacks;
@end