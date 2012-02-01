#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"

// ProfileController defaults keys
NSString *const kBodyMeterAgeKey = @"BodyMeterAgeKey";
NSString *const kBodyMeterGenderKey = @"BodyMeterGenderKey";
NSString *const kBodyMeterHeightKey = @"BodyMeterHeightKey";
NSString *const kBodyMeterWeightKey = @"BodyMeterWeightKey";
NSString *const kBodyMeterActivityKey = @"BodyMeterActivityKey";
NSString *const kBodyMeterIdealWeightKey = @"BodyMeterIdealWeightKey";

// ProfileController constants
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
NSString *const kBodyMeterProfileRightButton = @"Ver diagnóstico";
//NSLocalizedString(@"Ver diagnóstico", nil);

// Launcher title
NSString *const kBodyMeterTitle = @"Medidor corporal";

// Controller URLs
NSString *const kURLBodyMeterProfile = @"bundle://launcher/bodymeterprofile";

// Controller URL's call
NSString *const kURLBodyMeterProfileCall
        = @"bundle://launcher/bodymeterprofile";