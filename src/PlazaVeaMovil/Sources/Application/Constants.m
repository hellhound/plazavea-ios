// Application module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Application/Constants.h"

//application UUID constants
NSString *const kApplicationUUIDKey = @"ApplicationUUID";
NSString *const kAppId = @"163686483742056";
NSString *const kAccessTokenKey = @"FBAccessTokenKey";
NSString *const kExpirationDateKey = @"FBExpirationDateKey";
NSString *const kOAuthConsumerKey = @"RalVlTMQ0aQcHE7NWK6fg";
NSString *const kOAuthConsumerSecret =
        @"nKFcyf9F7dCZ3GDQa4CkChtIU92mJud4Lxoeu3mpc";
NSString *const kOAuthData = @"authData";

NSString *const kCoreDataDidBegin = @"coreDataDidBegin";
NSString *const kCoreDataDidEnd = @"coreDataDidEnd";

NSString *const kWorkingMessage = @"Cargando lista de productos...";
const CGFloat kLabelFontSize = 18.;
const CGFloat kAnimationDuration = .4;
const CGFloat kOverlayAlpha = .75;
const CGFloat kIndicatorY = 180.;
const CGFloat kLabelY = 250.;

NSString *const kDNIDefault = @"DNI";
NSString *const kPhoneDefault = @"Phone";
NSString *const kEmailDefault = @"e-mail";
NSString *const kRegistrationTitle = @"Regístrate en Vivanda Móvil";
NSString *const kRegsitrationButton = @"Enviar";
NSString *const kDNILabel = @"D.N.I.";
NSString *const kPhoneLabel = @"Teléfono";
NSString *const kEmailLabel = @"Email";

NSString *const kRegisterEndpointURL = @"/register/";
NSString *const kPostHTTPMethod = @"POST";
NSString *const kContentHTTPHeaderValue = @"application/json";
NSString *const kContentHTTPHeaderKey = @"Content-Type";
NSString *const kRegisterRequestString = @"%@=%@&%@=%@&%@=%@";
NSString *const kDNIResquestKey = @"dni";
NSString *const kPhoneRequestKey = @"phone";
NSString *const kEmailRequestKey = @"email";
