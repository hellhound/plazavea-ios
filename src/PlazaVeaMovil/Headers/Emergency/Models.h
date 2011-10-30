#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Common/Models/ManagedObject.h"

@interface EmergencyCategory : ManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *numbers;

@end

@interface EmergencyNumber : ManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) EmergencyCategory *category;
@end
