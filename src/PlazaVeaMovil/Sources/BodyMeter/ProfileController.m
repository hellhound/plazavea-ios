#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BodyMeter/Constants.h"
#import "BodyMeter/ProfileController.h"

@interface ProfileController ()

@property (nonatomic, retain) NSUserDefaults *defaults;
@end

@implementation ProfileController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    _age = [_defaults objectForKey:kBodyMeterAgeKey];
    
}

#pragma mark -
#pragma mark ProfileController (Public)

@synthesize age = _age, gender = _gender, height = _height, weight = _weight,
        activity = _activity;

#pragma mark -
#pragma mark ProfileController (Private)

@synthesize defaults = _defaults;

@end