#import <Foundation/Foundation.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/Models.h"

@implementation Profile

#pragma mark -
#pragma mark Profile (Public)

@synthesize age = _age, gender = _gender, height = _height, weight = _weight,
        activity = _activity, idealWeight = _idealWeight;

@end

@interface Diagnosis ()

@end

@implementation Diagnosis

#pragma mark -
#pragma mark Diagnosis (Public)

@synthesize profile = _profile, weightRange = _weightRange,
        bodyMassIndex = _bodyMassIndex, result = _result,
            metabolicBasalRate = _metabolicBasalRate,
            activityFactor = _activityFactor,
            requieredEnergy = _requieredEnergy,
            energyConsumption = _energyConsumption, time = _time;

- (id)initWithProfile:(Profile *)profile
{
    if ((self = [super init]) != nil) {
        _profile = [profile retain];
    }
    return self;
}

- (NSString *)weightRange 
{
    if (_weightRange == nil) {
        float lowerNormalWeight = [[_profile height] floatValue] * 
                [[_profile height] floatValue] * kDiagnosisThinnessIndex;
        float upperNormalWeight = [[_profile height] floatValue] * 
                [[_profile height] floatValue] * kDiagnosisNormalIndex;
        _weightRange = [[NSString alloc] initWithFormat:
                @"%.0f – %.0f kg", lowerNormalWeight, upperNormalWeight];
    }
    return _weightRange;
}

- (NSNumber *)bodyMassIndex 
{
    if (_bodyMassIndex == nil) {
        float BMI = [[_profile weight] floatValue] / 
                ([[_profile height] floatValue] * 
                    [[_profile height] floatValue]);
        _bodyMassIndex = [[NSNumber alloc] initWithFloat:BMI];
    }
    return _bodyMassIndex;
}

- (NSString *)result 
{
    if (_result == nil) {
        _result = [[NSString alloc] init];
        
        if ([_bodyMassIndex floatValue] < kDiagnosisThinnessIIIndex) {
            _result = kDiagnosisThinnessIILabel;
        } else if ([_bodyMassIndex floatValue] < kDiagnosisThinnessIndex) {
            _result = kDiagnosisThinnessLabel;
        } else if ([_bodyMassIndex floatValue] < kDiagnosisNormalIndex) {
            _result = kDiagnosisNormalLabel;
        } else if ([_bodyMassIndex floatValue] < kDiagnosisOverWeightIndex) {
            _result = kDiagnosisOverWeightLabel;
        } else if ([_bodyMassIndex floatValue] < kDiagnosisObesityIndex) {
            _result = kDiagnosisObesityLabel;
        } else if ([_bodyMassIndex floatValue] < kDiagnosisObesityIIIndex) {
            _result = kDiagnosisObesityIILabel;
        } else {
            _result = kDiagnosisObesityIIILabel;
        }
    }
    return _result;
}

- (NSNumber *)metabolicBasalRate 
{
    if (_metabolicBasalRate == nil) {
        float MBR;
        
        switch ([_profile gender]) {
            case kBodyMeterGenderUndefined:
                MBR = .0;
                break;
            case kBodyMeterGenderMale:
                MBR = kDiagnosisMaleMBRConstant + 
                        (kDiagnosisMaleMBRWeightFactor * 
                            [[_profile weight] floatValue]) + 
                            (kDiagnosisMaleMBRHeightFactor * 
                            [[_profile height] floatValue]) - 
                            (kDiagnosisMaleMBRAgeFactor * 
                            [[_profile age] floatValue]);
                break;
            case kBodyMeterGenderFemale:
                MBR = kDiagnosisFemaleMBRConstant + 
                        (kDiagnosisFemaleMBRWeightFactor * 
                            [[_profile weight] floatValue]) + 
                            (kDiagnosisFemaleMBRHeightFactor * 
                            [[_profile height] floatValue]) - 
                            (kDiagnosisFemaleMBRAgeFactor * 
                            [[_profile age] floatValue]);
                break;
            default:
                break;
        }
        _metabolicBasalRate = [[NSNumber alloc] initWithFloat:MBR];
    }
    return _metabolicBasalRate;
}

- (NSNumber *)activityFactor 
{
    if (_activityFactor == nil) {
        float AF;
        
        switch ([_profile activity]) {
            case kBodyMeterActivityUndefined:
                AF = .0;
                break;
            case kBodyMeterActivityMinimal:
                AF = kDiagnosisMinimalActivityFactor;
                break;
            case kBodyMeterActivityLight:
                AF = kDiagnosisLightActivityFactor;
                break;
            case kBodyMeterActivityModerate:
                AF = kDiagnosisModerateActivityFactor;
                break;
            case kBodyMeterActivityIntense:
                AF = kDiagnosisIntenseActivityFactor;
                break;
            default:
                break;
        }
        _activityFactor = [[NSNumber alloc] initWithFloat:AF];
    }
    return _activityFactor;
}

- (NSNumber *)requieredEnergy 
{
    if (_requieredEnergy == nil) {
        float RE = [[self metabolicBasalRate] floatValue] * 
                [[self activityFactor] floatValue];
        
        _requieredEnergy = [[NSNumber alloc] initWithFloat:RE];
    }
    return _requieredEnergy;
}

- (NSNumber *)energyConsumption 
{
    if (_energyConsumption == nil) {
        float EC;
        NSString *result = [self result];
        BOOL lossWeight = ([[_profile weight] floatValue] > 
                [[_profile idealWeight] floatValue]); 
        
        if ([[_profile weight] floatValue] == 
                [[_profile idealWeight] floatValue] || 
                    ![_profile idealWeight]) {
            EC = [[self requieredEnergy] floatValue];
        } else if ([result isEqualToString:kDiagnosisThinnessLabel] || 
                [result isEqualToString:kDiagnosisThinnessIILabel] || 
                    !lossWeight) {
            EC = ((kDiagnosisDaysOfMonth * [[self requieredEnergy] floatValue]) 
                    + ((kDiagnosisWeightGainFactor * 
                        [[_profile weight] floatValue]) * 
                        kDiagnosisEnergyConstant)) / kDiagnosisDaysOfMonth;
        } else {
            EC = ((kDiagnosisDaysOfMonth * [[self requieredEnergy] floatValue])
                    - ((kDiagnosisWeightLossFactor * 
                        [[_profile weight] floatValue]) * 
                        kDiagnosisEnergyConstant)) / kDiagnosisDaysOfMonth;
        }
        _energyConsumption = [[NSNumber alloc] initWithFloat:EC];
    }
    return _energyConsumption;
}

- (NSNumber *)time 
{
    if (_time == nil) {
        float T;

        if ([[_profile weight] floatValue] < 
                [[_profile idealWeight] floatValue]) {
            T = (([[_profile idealWeight] floatValue] - 
                    [[_profile weight] floatValue]) / 
                        (kDiagnosisWeightGainFactor * 
                        [[_profile weight] floatValue])) * 
                        kDiagnosisDaysOfMonth;
        } else if ([[_profile weight] floatValue] > 
                    [[_profile idealWeight] floatValue]) {
            T = (([[_profile weight] floatValue] -
                    [[_profile idealWeight] floatValue]) /
                        (kDiagnosisWeightLossFactor *
                        [[_profile weight] floatValue])) * 
                        kDiagnosisDaysOfMonth;
        } else {
            T = 0;
        }
        _time = [[NSNumber alloc] initWithFloat:T];
    }
    return _time;
}
@end

@implementation Meal

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_name release];
    [_calories release];
    [_carbohidrates release];
    [_proteins release];
    [_fat release];
    [super dealloc];
}

#pragma mark -
#pragma mark Meal

@synthesize carbohidrates = _carbohidrates, proteins = _proteins, fat = _fat,
        calories = _calories, name = _name;

- (id)initWithName:(NSString *)name energyRequirement:(NSNumber *)energy
{
    if ((self = [super init]) != nil) {
        _name = [name retain];
        _calories = [energy retain];
        _carbohidrates = [[NSNumber alloc] initWithFloat:
                ([energy floatValue] * kDiagnosisCarbsFactor)];
        _proteins = [[NSNumber alloc] initWithFloat:
                ([energy floatValue] * kDiagnosisProteinsFactor)];
        _fat = [[NSNumber alloc] initWithFloat:
                ([energy floatValue] * kDiagnosisFatFactor)];
    }
    return self;
}

@end

@interface Meals ()

@property (nonatomic, assign) BOOL snacks;
@end

@implementation Meals

#pragma mark -
#pragma mark Meals (Public)

@synthesize meals = _meals, energy = _energy;

- (id)initWithEnergyRequirement:(NSNumber *)energy snacks:(BOOL)snacks
{
    if ((self = [super init]) != nil) {
        _energy = [energy retain];
        _snacks = snacks;
    }
    return self;
}

- (NSArray *)meals
{
    if (_meals == nil) {
        NSMutableArray *mutableMeals = [[NSMutableArray alloc] init];
        if (_snacks) {
            Meal *breakfast = [[Meal alloc]
                    initWithName:kDiagnosis1of5MealsLabel 
                        energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis1of5MealsFactor)]];
            Meal *snack1 = [[Meal alloc] initWithName:kDiagnosis2of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis2of5MealsFactor)]];
            Meal *lunch = [[Meal alloc] initWithName:kDiagnosis3of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis3of5MealsFactor)]];
            Meal *snack2 = [[Meal alloc] initWithName:kDiagnosis4of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis4of5MealsFactor)]];
            Meal *dinner = [[Meal alloc] initWithName:kDiagnosis5of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis5of5MealsFactor)]];
            
            [mutableMeals addObject:breakfast];
            [mutableMeals addObject:snack1];
            [mutableMeals addObject:lunch];
            [mutableMeals addObject:snack2];
            [mutableMeals addObject:dinner];
        } else {
            Meal *breakfast = [[Meal alloc]
                    initWithName:kDiagnosis1of5MealsLabel 
                        energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis1of3MealsFactor)]];
            Meal *lunch = [[Meal alloc] initWithName:kDiagnosis3of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis2of3MealsFactor)]];
            Meal *dinner = [[Meal alloc] initWithName:kDiagnosis5of5MealsLabel
                    energyRequirement:[NSNumber numberWithFloat:
                        ([_energy floatValue] * kDiagnosis3of3MealsFactor)]];
            
            [mutableMeals addObject:breakfast];
            [mutableMeals addObject:lunch];
            [mutableMeals addObject:dinner];
        }
        _meals = [[NSArray alloc] initWithArray:mutableMeals];
    }
    return _meals;
}

#pragma mark -
#pragma mark Meals (Private)

@synthesize snacks = _snacks;

@end