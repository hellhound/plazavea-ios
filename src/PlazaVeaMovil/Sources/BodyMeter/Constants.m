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
//NSLocalizedString(@"Delgadez II", nil)
NSString *const kDiagnosisThinnessLabel = @"Delgadez";
//NSLocalizedString(@"Delgadez", nil)
NSString *const kDiagnosisNormalLabel = @"Normal";
//NSLocalizedString(@"Normal", nil)
NSString *const kDiagnosisOverWeightLabel = @"Sobrepeso";
//NSLocalizedString(@"Sobrepeso", nil)
NSString *const kDiagnosisObesityLabel = @"Obesidad";
//NSLocalizedString(@"Obesidad", nil)
NSString *const kDiagnosisObesityIILabel = @"Obesidad II";
//NSLocalizedString(@"Obesidad II", nil)
NSString *const kDiagnosisObesityIIILabel = @"Obesidad III";
//NSLocalizedString(@"Obesidad III", nil)

NSString *const kDiagnosis1of5MealsLabel = @"Desayuno";
//NSLocalizedString(@"Desayuno", nil)
NSString *const kDiagnosis2of5MealsLabel = @"Media mañana";
//NSLocalizedString(@"Media mañana", nil)
NSString *const kDiagnosis3of5MealsLabel = @"Almuerzo";
//NSLocalizedString(@"Almuerzo", nil)
NSString *const kDiagnosis4of5MealsLabel = @"Media tarde";
//NSLocalizedString(@"Media Tarde", nil)
NSString *const kDiagnosis5of5MealsLabel = @"Cena";
//NSLocalizedString(@"Cena", nil)

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
const CGFloat kBodyMeterColor = .85;
NSString *const kBodyMeterShowDiagnosisNotification = @"showDiagnosis";
NSString *const kbodyMeterGoToLauncherNotification = @"goToLauncher";

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
NSString *const kBodyMeterCMISufix = @"%.1f";
//NSLocalizedString(@"%.1f", nil);
NSString *const kBodyMeterConsumptionSufix = @"%.0f Kcal/día";
//NSLocalizedString(@"%.0f Kcal/día", nil);
NSString *const kBodyMeterTimeSufix = @"%.0f días";
//NSLocalizedString(@"%.0f días", nil);

// ConsumptionController constants
NSString *const kBodyMeterConsumptionBackButton = @"Consumo";
//NSLocalizedString(@"Consumo", nil)
NSString *const kBodyMeterMealsADay = @"%i comidas al día";
//NSLocalizedString(@"%i comidas al día", nil)

// MealsController constants
NSString *const kBodyMeterMealsBackButton = @"Comidas";
//NSLocalizedString(@"Comidas", nil)
NSString *const kBodyMeterCaloriesLabel = @"Kilocalorías";
//NSLocalizedString(@"Calorías", nil)
NSString *const kBodyMeterCarbohidratesLabel = @"Carbohidratos";
//NSLocalizedString(@"Carbohidratos", nil)
NSString *const kBodyMeterProteinsLabel = @"Proteínas";
//NSLocalizedString(@"Proteínas", nil)
NSString *const kBodyMeterFatLabel = @"Grasas";
//NSLocalizedString(@"Grasas", nil)
NSString *const kBodyMeterCaloriesSufix = @"%.0f kcal";
//NSLocalizedString(@"%.0f kcal", nil)
NSString *const kBodyMeterGramsSufix = @"%.0f g";
//NSLocalizedString(@"%.0f g", nil)

// RecomendationsController constants
NSString *const kBodyMeterRecomendationsBackButton = @"Recomendaciones";
//NSLocalizedString(@"Recomendaciones", nil)
NSString *const kRecomendationsThinnessII =
        @"Beber es una obligación, 35 ml de agua por kg de peso corporal al " \
        "día, si aumentas tu actividad física o tienes sed consume más " \
        "agua.\n\nComer es un placer, hay que variar los menús.\n\nConsume " \
        "alimentos probióticos como yogur, leche agria.\n\nConsume " \
        "pescado entre 2 y 3 veces a la semana (1 ración = 150 g).\n\n" \
        "Consume huevos de 4 a 5 veces a la semana.\n\nComiendo frutas " \
        "cítricas, de 1 a 2 unidades diarias, y no cítricas 2 raciones de " \
        "150 gramos diarios disminuirás el stress y alejaras a las " \
        "enfermedades.\n\nNo abuses de alimentos ricos en grasas de origen " \
        "animal.\n\nUsa aceite de sacha inchi u oliva en las ensaladas o " \
        "comidas servidas, hasta 6 cucharadas al día.\n\nNo olvides consumir " \
        "productos lácteos de 3 a 4 raciones al día (1 ración de queso = 40 " \
        "g, leche evaporada = 100 ml, leche fresca = 240 ml y yogur = 150 " \
        "ml).\n\nConsume preparaciones a base de cereales y tubérculos.";
//NSLocalizedString \
(@"Beber es una obligación, 35 ml de agua por kg de peso corporal al " \
"día, si aumentas tu actividad física o tienes sed consume más " \
"agua.\n\nComer es un placer, hay que variar los menús.\n\nConsume " \
"alimentos probióticos como yogur, leche agria.\n\nConsume " \
"pescado entre 2 y 3 veces a la semana (1 ración = 150 g).\n\n" \
"Consume huevos de 4 a 5 veces a la semana.\n\nComiendo frutas " \
"cítricas, de 1 a 2 unidades diarias, y no cítricas 2 raciones de " \
"150 gramos diarios disminuirás el stress y alejaras a las " \
"enfermedades.\n\nNo abuses de alimentos ricos en grasas de origen " \
"animal.\n\nUsa aceite de sacha inchi u oliva en las ensaladas o " \
"comidas servidas, hasta 6 cucharadas al día.\n\nNo olvides consumir " \
"productos lácteos de 3 a 4 raciones al día (1 ración de queso = 40 " \
"g, leche evaporada = 100 ml, leche fresca = 240 ml y yogur = 150 " \
"ml).\n\nConsume preparaciones a base de cereales y tubérculos.", nil)
// Launcher title
NSString *const kRecomendationsThinness =
        @"Beber es una obligación, 35 ml de agua por kg de peso corporal " \
        " al día. Si aumentas tu actividad física o tienes sed consume más " \
        "agua.\n\nComer es un placer, hay que variar los menús.\n\n" \
        "Consume pescado entre 2 y 3 veces a la semana (1 ración = 150 g)." \
        "\n\nConsume huevos de 3 a 4 veces a la semana.\n\nCome frutas " \
        "cítricas, de 1 a 2 unidades diarias, y no citricas 2 raciones de " \
        "150 gramos diarios.\n\nNo abuses de alimentos ricos en grasas de " \
        "origen animal.\n\nLa fruta entera es una importante fuente de " \
        "vitaminas, minerales y fibra.\n\nUsa aceite de sacha inchi u " \
        "oliva en las ensaladas o comidas servidas, hasta 5 cucharadas al " \
        "día.\n\nNo olvides consumir productos lacteos 3 a 4 raciones al " \
        "día (1 ración de queso = 40 g, leche evaporada = 100 ml, leche " \
        "fresca = 240 ml y yogur = 150 ml).\n\nConsume preparaciones a " \
        "base de cereales y tubérculos.";
//NSLocalizedString \
(@"Beber es una obligación, 35 ml de agua por kg de peso corporal " \
" al día. Si aumentas tu actividad física o tienes sed consume más " \
"agua.\n\nComer es un placer, hay que variar los menús.\n\n" \
"Consume pescado entre 2 y 3 veces a la semana (1 ración = 150 g)." \
"\n\nConsume huevos de 3 a 4 veces a la semana.\n\nCome frutas " \
"cítricas, de 1 a 2 unidades diarias, y no citricas 2 raciones de " \
"150 gramos diarios.\n\nNo abuses de alimentos ricos en grasas de " \
"origen animal.\n\nLa fruta entera es una importante fuente de " \
"vitaminas, minerales y fibra.\n\nUsa aceite de sacha inchi u " \
"oliva en las ensaladas o comidas servidas, hasta 5 cucharadas al " \
"día.\n\nNo olvides consumir productos lacteos 3 a 4 raciones al " \
"día (1 ración de queso = 40 g, leche evaporada = 100 ml, leche " \
"fresca = 240 ml y yogur = 150 ml).\n\nConsume preparaciones a " \
"base de cereales y tubérculos.", nil)
NSString *const kRecomendationsNormal =
        @"Dieta equilibrada, buena hidratación y ejercicio son los pilares " \
        "de la salud a cualquier edad.\n\nRealizar actividad física es " \
        "indispensable, 30 minutos al día o 10 minutos en 3 momentos " \
        "diferentes y si quieres músculos definidos el ejercicio con pesas " \
        "te ayudará.\n\nBeber es una obligación, 35 ml de agua por kg de " \
        "peso corporal por día. Si aumentas tu actividad física o tienes " \
        "sed consume más agua.\n\nLas menestras tienen fibra, consúmelas " \
        "al menos 2 veces por semana.\n\nPara controlar el hambre comer " \
        "alimentos ricos en fibra, 25 gr al día.\n\nCome frutas ricas en " \
        "vitamina C, las que sean posibles con cáscara y hollejo aportan " \
        "más fibra.\n\nComer un puñado de frutos secos sin sal ni azúcar " \
        "como colación.\n\nEmplea en comer tu almuerzo y cena de 40 a 50 " \
        "minutos.\n\nNo te quedes sin comer por más de 4 horas.\n\nBeber " \
        "vino o cerveza es saludable dentro de los límites, de 1 a 3 " \
        "unidades en el hombre y de 1 a 1.5 en la mujer (1 unidad de vino " \
        "= 80 – 100ml) (1 unidad de cerveza = 200 ml)";
//NSLocalizedString \
(@"Dieta equilibrada, buena hidratación y ejercicio son los pilares " \
"de la salud a cualquier edad.\n\nRealizar actividad física es " \
"indispensable, 30 minutos al día o 10 minutos en 3 momentos " \
"diferentes y si quieres músculos definidos el ejercicio con pesas " \
"te ayudará.\n\nBeber es una obligación, 35 ml de agua por kg de " \
"peso corporal por día. Si aumentas tu actividad física o tienes " \
"sed consume más agua.\n\nLas menestras tienen fibra, consúmelas " \
"al menos 2 veces por semana.\n\nPara controlar el hambre comer " \
"alimentos ricos en fibra, 25 gr al día.\n\nCome frutas ricas en " \
"vitamina C, las que sean posibles con cáscara y hollejo aportan " \
"más fibra.\n\nComer un puñado de frutos secos sin sal ni azúcar " \
"como colación.\n\nEmplea en comer tu almuerzo y cena de 40 a 50 " \
"minutos.\n\nNo te quedes sin comer por más de 4 horas.\n\nBeber " \
"vino o cerveza es saludable dentro de los límites, de 1 a 3 " \
"unidades en el hombre y de 1 a 1.5 en la mujer (1 unidad de vino " \
"= 80 – 100ml) (1 unidad de cerveza = 200 ml)", nil)
NSString *const kRecomendationsOverWeight =
        @"No saltes ninguna comida ni dejes pasar más de 4 horas sin comer." \
        "\n\nEvita los alimentos con azúcar, pasteles, galletas, " \
        "refrescos, snacks y alcohol.\n\nMastica lentamente, saborea " \
        "cada bocado y demórate en comer de 40 a 50 minutos, sin prisa." \
        "\n\nRealizar actividad física es indispensable, más de 30 minutos " \
        "diarios.\n\nBeber es una obligación, 35 ml de agua por kg de peso " \
        "corporal por día. Si aumentas tu actividad física o tienes sed " \
        "consume más agua.\n\nPara controlar el hambre comer alimentos " \
        "ricos en fibra, 25 g al día, y tomar antes del almuerzo 1 vaso " \
        "de agua tibia.\n\nPuedes comer helados pero a base de agua y " \
        "frutas.\n\nUsar aceite de sacha inchi u oliva en las ensaladas, " \
        "2 cucharada al día.\n\nEvita las vísceras (anticuchos, hígado, " \
        "cau cau, otros).\n\nConsume frutas y verduras, 5 raciones al día, " \
        "de preferencia crudas.";
//NSLocalizedString \
(@"No saltes ninguna comida ni dejes pasar más de 4 horas sin comer." \
"\n\nEvita los alimentos con azúcar, pasteles, galletas, " \
"refrescos, snacks y alcohol.\n\nMastica lentamente, saborea " \
"cada bocado y demórate en comer de 40 a 50 minutos, sin prisa." \
"\n\nRealizar actividad física es indispensable, más de 30 minutos " \
"diarios.\n\nBeber es una obligación, 35 ml de agua por kg de peso " \
"corporal por día. Si aumentas tu actividad física o tienes sed " \
"consume más agua.\n\nPara controlar el hambre comer alimentos " \
"ricos en fibra, 25 g al día, y tomar antes del almuerzo 1 vaso " \
"de agua tibia.\n\nPuedes comer helados pero a base de agua y " \
"frutas.\n\nUsar aceite de sacha inchi u oliva en las ensaladas, " \
"2 cucharada al día.\n\nEvita las vísceras (anticuchos, hígado, " \
"cau cau, otros).\n\nConsume frutas y verduras, 5 raciones al día, " \
"de preferencia crudas.", nil)
NSString *const kRecomendationsObesity =
        @"Para perder peso de forma sana, no hay que eliminar ningún " \
        "alimento.\n\nComer algún alimento crudo en cada comida.\n\nPara " \
        "controlar el hambre comer alimentos ricos en fibra, 25 g al día." \
        "\n\nRealizar actividad física es indispensable.\n\nBeber es una " \
        "obligación, 35 ml de agua por Kg de peso corporal al día. Si " \
        "aumentas tu actividad física o tienes sed consume más agua.\n\n" \
        "Usar aceite de sacha inchi u oliva en las ensaladas, 1 cucharada " \
        "al día.\n\nCome las frutas que sean posibles con cáscara y " \
        "hollejo, aportan más fibra.\n\nLimitar el consumo de alcohol, " \
        "tienen más calorías que los carbohidratos y proteínas.\n\nEvita " \
        "las vísceras (anticuchos, hígado, cau cau, otros).\n\nSi tu dieta " \
        "está por debajo de las 1200 kcal consulta con tu medico para " \
        "consumir multivitamínicos, es necesario.";
//NSLocalizedString \
(@"Para perder peso de forma sana, no hay que eliminar ningún " \
"alimento.\n\nComer algún alimento crudo en cada comida.\n\nPara " \
"controlar el hambre comer alimentos ricos en fibra, 25 g al día." \
"\n\nRealizar actividad física es indispensable.\n\nBeber es una " \
"obligación, 35 ml de agua por Kg de peso corporal al día. Si " \
"aumentas tu actividad física o tienes sed consume más agua.\n\n" \
"Usar aceite de sacha inchi u oliva en las ensaladas, 1 cucharada " \
"al día.\n\nCome las frutas que sean posibles con cáscara y " \
"hollejo, aportan más fibra.\n\nLimitar el consumo de alcohol, " \
"tienen más calorías que los carbohidratos y proteínas.\n\nEvita " \
"las vísceras (anticuchos, hígado, cau cau, otros).\n\nSi tu dieta " \
"está por debajo de las 1200 kcal consulta con tu medico para " \
"consumir multivitamínicos, es necesario.", nil)
NSString *const kRecomendationsObesityII =
        @"Para controlar el hambre comer alimentos ricos en fibra, 25 g " \
        "al día.\n\nBeber es una obligación, 35 ml de agua por kg de peso " \
        "corporal al día. Si aumentas tu actividad física o tienes sed " \
        "consume más agua.\n\nCome las frutas que sean posibles con cáscara " \
        "y hollejo, aportan más fibra.\n\nCenar 2 horas antes de acostarse." \
        "\n\nCocinar lo justo y no sobrepasarse con las raciones. Las sobras " \
        "son una tentación peligrosa.\n\nUsar aceite de sacha inchi u oliva " \
        "en las ensaladas, una cucharada al día.\n\nPreferir alimentos " \
        "cocinados al vapor, a la plancha, al horno, sancochados y los " \
        "guisos sin jugo.\n\nCome pescado al menos 2 veces a la semana " \
        "y evitar las vísceras (anticuchos, hígado, cau cau, otros).\n\n" \
        "Evita  la soledad y el aislamiento.\n\nConsume ensaladas de " \
        "verduras frescas o cocidas 2 raciones al día de 150 a 200 g cada " \
        "una.";
//NSLocalizedString \
@"Para controlar el hambre comer alimentos ricos en fibra, 25 g " \
"al día.\n\nBeber es una obligación, 35 ml de agua por kg de peso " \
"corporal al día. Si aumentas tu actividad física o tienes sed " \
"consume más agua.\n\nCome las frutas que sean posibles con cáscara " \
"y hollejo, aportan más fibra.\n\nCenar 2 horas antes de acostarse." \
"\n\nCocinar lo justo y no sobrepasarse con las raciones. Las sobras " \
"son una tentación peligrosa.\n\nUsar aceite de sacha inchi u oliva " \
"en las ensaladas, una cucharada al día.\n\nPreferir alimentos " \
"cocinados al vapor, a la plancha, al horno, sancochados y los " \
"guisos sin jugo.\n\nCome pescado al menos 2 veces a la semana " \
"y evitar las vísceras (anticuchos, hígado, cau cau, otros).\n\n" \
"Evita  la soledad y el aislamiento.\n\nConsume ensaladas de " \
"verduras frescas o cocidas 2 raciones al día de 150 a 200 g cada " \
"una.", nil)
NSString *const kRecomendationsObesityIII =
        @"Beber es una obligación, 35 ml de agua por kg de peso corporal " \
        "al día. Si aumentas tu actividad física o tienes sed consume más " \
        "agua.\n\nRealiza ejercicio (caminata, jardinería, baile), inicia " \
        "con 10 minutos y vas aumentando el tiempo.\n\nSustituir el azúcar " \
        "o elaborar recetas caseras con edulcorantes no nutritivos tales " \
        "como la sacarina, el ciclamato, el aspartame y el sorbitol, ya " \
        "que no ???.\n\nElige alimentos ricos en fibra, 25 gramos al día, " \
        "ayudará a controlar el hambre.\n\nCome pescado al menos 2 veces " \
        "a la semana.\n\nCenar 2 horas antes de acostarse.\n\nCome " \
        "ensaladas de verduras frescas o cocidas 2 raciones al día de " \
        "150 a 200 g cada una.\n\nUsar aceite de sacha inchi u oliva en " \
        "las ensaladas, 1 cucharada al día.\n\nPreferir alimentos " \
        "cocinados al vapor, a la plancha, al horno, escalfadas, " \
        "sancochados y los guisos sin jugo.\n\nDisminuir la ingesta de " \
        "alcohol y sal.";
//NSLocalizedString \
(@"Beber es una obligación, 35 ml de agua por kg de peso corporal " \
"al día. Si aumentas tu actividad física o tienes sed consume más " \
"agua.\n\nRealiza ejercicio (caminata, jardinería, baile), inicia " \
"con 10 minutos y vas aumentando el tiempo.\n\nSustituir el azúcar " \
"o elaborar recetas caseras con edulcorantes no nutritivos tales " \
"como la sacarina, el ciclamato, el aspartame y el sorbitol, ya " \
"que no ???.\n\nElige alimentos ricos en fibra, 25 gramos al día, " \
"ayudará a controlar el hambre.\n\nCome pescado al menos 2 veces " \
"a la semana.\n\nCenar 2 horas antes de acostarse.\n\nCome " \
"ensaladas de verduras frescas o cocidas 2 raciones al día de " \
"150 a 200 g cada una.\n\nUsar aceite de sacha inchi u oliva en " \
"las ensaladas, 1 cucharada al día.\n\nPreferir alimentos " \
"cocinados al vapor, a la plancha, al horno, escalfadas, " \
"sancochados y los guisos sin jugo.\n\nDisminuir la ingesta de " \
"alcohol y sal.", nil)

// Laucher title
NSString *const kBodyMeterTitle = @"Medidor corporal";

// Controller URLs
NSString *const kURLBodyMeterProfile = @"bundle://launcher/bodymeterprofile";
NSString *const kURLBodyMeterDiagnosis =
        @"bundle://launcher/bodymeterdiagnosis";

// Controller URL's call
NSString *const kURLBodyMeterProfileCall =
        @"bundle://launcher/bodymeterprofile";
NSString *const kURLBodyMeterDiagnosisCall =
        @"bundle://launcher/bodymeterdiagnosis";