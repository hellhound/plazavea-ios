#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"

// Diagnosis model constants
const float kDiagnosisThinnessIIIndex = 17.;
const float kDiagnosisThinnessIndex = 18.5;
const float kDiagnosisNormalIndex = 25.;
const float kDiagnosisOverWeightIndex = 30.;
const float kDiagnosisObesityIndex = 35.;
const float kDiagnosisObesityIIIndex = 40.;

const float kDiagnosisMaleMBRConstant = 664.;
const float kDiagnosisMaleMBRWeightFactor = 13.75;
const float kDiagnosisMaleMBRHeightFactor = 5.003;
const float kDiagnosisMaleMBRAgeFactor = 6.77;

const float kDiagnosisFemaleMBRConstant = 655.1;
const float kDiagnosisFemaleMBRWeightFactor = 9.6;
const float kDiagnosisFemaleMBRHeightFactor = 1.85;
const float kDiagnosisFemaleMBRAgeFactor = 4.676;

const float kDiagnosisMinimalActivityFactor = 1.2;
const float kDiagnosisLightActivityFactor = 1.55;
const float kDiagnosisModerateActivityFactor = 1.78;
const float kDiagnosisIntenseActivityFactor = 2.1;

const float kDiagnosisEnergyConstant = 7000.;
const float kDiagnosisWeightGainFactor = 0.05;
const float kDiagnosisWeightLossFactor = 0.035;
const float kDiagnosisDaysOfMonth = 30.;

const float kDiagnosis1of5MealsFactor = 0.2;
const float kDiagnosis2of5MealsFactor = 0.1;
const float kDiagnosis3of5MealsFactor = 0.4;
const float kDiagnosis4of5MealsFactor = 0.1;
const float kDiagnosis5of5MealsFactor = 0.2;

const float kDiagnosis1of3MealsFactor = 0.3;
const float kDiagnosis2of3MealsFactor = 0.5;
const float kDiagnosis3of3MealsFactor = 0.2;

const float kDiagnosisCarbsFactor = 0.15;
const float kDiagnosisProteinsFactor = 0.03;
const float kDiagnosisFatFactor = 0.03;

NSString *const kDiagnosisThinnessIILabel = @"Delgadez II";
NSString *const kDiagnosisThinnessLabel = @"Delgadez";
NSString *const kDiagnosisNormalLabel = @"Normal";
NSString *const kDiagnosisOverWeightLabel = @"Sobrepeso";
NSString *const kDiagnosisObesityLabel = @"Obesidad";
NSString *const kDiagnosisObesityIILabel = @"Obesidad II";
NSString *const kDiagnosisObesityIIILabel = @"Obesidad III";

NSString *const kDiagnosis1of5MealsLabel = @"Desayuno";
NSString *const kDiagnosis2of5MealsLabel = @"Media mañana";
NSString *const kDiagnosis3of5MealsLabel = @"Almuerzo";
NSString *const kDiagnosis4of5MealsLabel = @"Media tarde";
NSString *const kDiagnosis5of5MealsLabel = @"Cena";

// ProfileController defaults keys
NSString *const kBodyMeterAgeKey = @"BodyMeterAgeKey";
NSString *const kBodyMeterGenderKey = @"BodyMeterGenderKey";
NSString *const kBodyMeterHeightKey = @"BodyMeterHeightKey";
NSString *const kBodyMeterWeightKey = @"BodyMeterWeightKey";
NSString *const kBodyMeterActivityKey = @"BodyMeterActivityKey";
NSString *const kBodyMeterIdealWeightKey = @"BodyMeterIdealWeightKey";

// ProfileController constants
NSString *const kBodyMeterProfileBackButton = @"Perfil";
//NSLocalizedString(@"Perfil", nil)
NSString *const kBodyMeterUndefinedLabel = @"No hay información";
//NSLocalizedString(@"No hay información", nil)
NSString *const kBodyMeterAgeLabel = @"Edad";
//NSLocalizedString(@"Edad", nil)
NSString *const kBodyMeterAgeSufix = @"%i años";
//NSLocalizedString(@"%i años", nil)
NSString *const kBodyMeterGenderLabel = @"Sexo";
//NSLocalizedString(@"Sexo", nil)
NSString *const kBodyMeterMaleLabel = @"Masculino";
//NSLocalizedString(@"Masculino", nil)
NSString *const kBodyMeterFemaleLabel = @"Femenino";
//NSLocalizedString(@"Femenino", nil)
NSString *const kBodyMeterHeightLabel = @"Estatura";
//NSLocalizedString(@"Estatura", nil)
NSString *const kBodyMeterHeightSufix = @"%.2f m";
//NSLocalizedString(@"%.2f m", nil)
NSString *const kBodyMeterWeightLabel = @"Peso";
//NSLocalizedString(@"Peso", nil)
NSString *const kBodyMeterWeightSufix = @"%i kg";
//NSLocalizedString(@"%i kg", nil)
NSString *const kBodyMeterActivityLabel = @"Actividad";
//NSLocalizedString(@"Actividad", nil)
NSString *const kBodyMeterMinimalLabel = @"Mínima";
//NSLocalizedString(@"Mínima", nil)
NSString *const kBodyMeterLightLabel = @"Ligera";
//NSLocalizedString(@"Ligera", nil)
NSString *const kBodyMeterModerateLabel = @"Moderada";
//NSLocalizedString(@"Moderada", nil)
NSString *const kBodyMeterIntenseLabel = @"Intensa";
//NSLocalizedString(@"Intensa", nil)
NSString *const kBodyMeterIdealWeightLabel = @"Peso ideal";
//NSLocalizedString(@"Peso ideal", nil)
NSString *const kBodyMeterProfileHeaderLabel = @"Ingresa tu perfil";
//NSLocalizedString(@"Ingresa tu perfil", nil)
NSString *const kBodyMeterWeightHeaderLabel = @"Ingresa tu meta (opcional)";
//NSLocalizedString(@"Ingresa tu meta (opcional)", nil)
NSString *const kBodyMeterProfileFooterLabel =
        @"Actividad:\nMínima implica trabajo sentado el mayor tiempo " \
        "sin ningún tipo de ejercicio físico.\nLigera es cualquier " \
        "trabajo en el que hay cierto grado de ejercicio físico." \
        "\nModerada se considera en trabajos donde hay mucha más " \
        "actividad física o cuando realizas deporte de cualquier " \
        "tipo.\nIntensa es la que realizan deportistas calificados.";
//NSLocalizedString \
(@"Actividad:\nMínima implica trabajo sentado el mayor tiempo " \
"sin ningún tipo de ejercicio físico.\nLigera es cualquier " \
"trabajo en el que hay cierto grado de ejercicio físico." \
"\nModerada se considera en trabajos donde hay mucha más " \
"actividad física o cuando realizas deporte de cualquier " \
"tipo.\nIntensa es la que realizan deportistas calificados.", nil)
NSString *const kBodyMeterWeightFooterLabel = 
        @"Si ingresas una meta podrás ver el consumo energético y " \
        "recomendaciones para lograrla.";
//NSLocalizedString \
(@"Si ingresas una meta podrás ver el consumo energético y " \
"recomendaciones para lograrla.", nil)
NSString *const kBodyMeterProfileAlertTitle = @"No has completado tu perfil";
//NSLocalizedString(@"No has completado tu perfil", nil);
NSString *const kBodyMeterProfileAlertMessage = 
        @"Ingresa tu perfil para que puedas beneficiarte con las " \
        "recomendaciones que el\nMedidor Corporal\nte ofrece";
//NSLocalizedString \
(@"Ingresa tu perfil para que puedas beneficiarte con las " \
"recomendaciones que el\nMedidor Corporal\nte ofrece", nil);
NSString *const kBodyMeterProfileAlertButton = @"OK";
//NSLocalizedString(@"OK", nil);
NSString *const kBodyMeterAgeEntry = @"Ingresa tu edad";
//NSLocalizedString(@"Ingresa tu edad", nil);
NSString *const kBodyMeterHeightEntry =
        @"Ingresa tu estutura\n(en centímetros)";
//NSLocalizedString(@"Ingresa tu estutura\n(en centímetros)", nil);
NSString *const kBodyMeterWeightEntry = @"Ingresa tu peso\n(en kilogramos)";
//NSLocalizedString(@"Ingresa tu peso\n(en kilogramos)", nil);
NSString *const kBodyMeterIdealWeightEntry =
        @"Ingresa tu peso ideal\n(en kilogramos)";
//NSLocalizedString(@"Ingresa tu peso ideal\n(en kilogramos)", nil);
NSString *const kBodyMeterEntryAlertCancel = @"Cancelar";
//NSLocalizedString(@"Cancelar", nil);
NSString *const kBodyMeterEntryAlertOK = @"OK";
//NSLocalizedString(@"OK", nil);

// DiagnosisController constants
NSString *const kBodyMeterDiagnosisBackButton = @"Diagnóstico";
//NSLocalizedString(@"Diagnóstico", nil);
NSString *const kBodyMeterRangeLabel = @"Rango normal de peso";
//NSLocalizedString(@"Rango normal de peso", nil);
NSString *const kBodyMeterCMILabel = @"Índice de masa corporal";
//NSLocalizedString(@"Índice de masa corporal", nil);
NSString *const kBodyMeterResultLabel = @"Resultado";
//NSLocalizedString(@"Resultado", nil);
NSString *const kBodyMeterCalorieConsumptionLabel = @"Consumo de calorías";
//NSLocalizedString(@"Consumo de calorías", nil);
NSString *const kBodyMeterTimeLabel = @"Tiempo";
//NSLocalizedString(@"Tiempo", nil);
NSString *const kBodyMeterEnergyConsumptionLabel = @"Consumo energético";
//NSLocalizedString(@"Consumo energético", nil);
NSString *const kBodyMeterRecomendationsLabel = @"Recomendaciones";
//NSLocalizedString(@"Recomendaciones", nil);
NSString *const kBodyMeterDiagnosisLabel = @"Diagnóstico actual (%i kg)";
//NSLocalizedString(@"Diagnóstico actual (%i kg)", nil);
NSString *const kBodyMeterGoalLabel = @"Meta del usuario (%i kg)";
//NSLocalizedString(@"Meta del usuario (%i kg)", nil);

// Launcher title
NSString *const kBodyMeterTitle = @"Medidor corporal";

// Controller URLs
NSString *const kURLBodyMeterProfile = @"bundle://launcher/bodymeterprofile";

// Controller URL's call
NSString *const kURLBodyMeterProfileCall
        = @"bundle://launcher/bodymeterprofile";