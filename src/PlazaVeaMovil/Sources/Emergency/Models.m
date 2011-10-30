#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Common/Additions/NSString+Additions.h"
#import "Common/Additions/NSManagedObjectContext+Additions.h"
#import "Common/Models/ManagedObject.h"
#import "Emergency/Constants.h"
#import "Emergency/Models.h"

static NSRelationshipDescription *kCategoriesRelationship;
static NSRelationshipDescription *kNumbersRelationship;

@implementation EmergencyCategory

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kEmergencyCategoryName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    // setting properties into the entity
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, nil]]; 
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *numbersRelationship =
            [self relationshipWithName:kEmergencyCategoryNumbers];

    [numbersRelationship setName:kEmergencyCategoryNumbers];
    [numbersRelationship setDestinationEntity:[EmergencyNumber entity]];
    [numbersRelationship setInverseRelationship:
            [EmergencyNumber relationshipWithName:kEmergencyNumberCategory]];
    [numbersRelationship setOptional:NO];
    [numbersRelationship setMaxCount:-1]; // to-many relationship
    [numbersRelationship setMinCount:0];
    [numbersRelationship setDeleteRule:NSCascadeDeleteRule];
    return [relationships setByAddingObject:numbersRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)relationshipName
{
    NSRelationshipDescription *relationship =
            [super relationshipWithName:relationshipName];

    if (relationship != nil)
        return relationship;
    if ([relationshipName isEqualToString:kEmergencyNumberCategory]) {
        if (kCategoriesRelationship == nil)
            kCategoriesRelationship = [[NSRelationshipDescription alloc] init];
        return kCategoriesRelationship; 
    }
    return nil;
}

#pragma mark -
#pragma mark EmergencyCategory (public)
@dynamic name, numbers;
@end


@implementation EmergencyNumber

#pragma mark -
#pragma mark ManagedObject (Overridable)

+ (NSSet *)attributes
{
    NSSet *attributes = [super attributes];
    NSAttributeDescription *name =
            [[[NSAttributeDescription alloc] init] autorelease];

    [name setName:kEmergencyNumberName];
    [name setAttributeType:NSStringAttributeType];
    [name setOptional:NO];

    NSAttributeDescription *phone =
            [[[NSAttributeDescription alloc] init] autorelease];

    [phone setName:kEmergencyNumberPhone];
    [phone setAttributeType:NSStringAttributeType];
    [phone setOptional:NO];

    // setting properties into the entity
    return [attributes setByAddingObjectsFromSet:
            [NSSet setWithObjects:name, phone, nil]]; 
}

+ (NSSet *)relationships
{
    NSSet *relationships = [super relationships];
    NSRelationshipDescription *categoryRelationship = 
        [self relationshipWithName:kEmergencyNumberCategory];

    [categoryRelationship setName:kEmergencyNumberCategory];
    [categoryRelationship setDestinationEntity:[EmergencyCategory entity]];
    [categoryRelationship setInverseRelationship:
            [EmergencyCategory relationshipWithName:kEmergencyCategoryNumbers]];
    [categoryRelationship setOptional:NO];
    [categoryRelationship setMaxCount:1];
    [categoryRelationship setMinCount:1];
    [categoryRelationship setDeleteRule:NSNullifyDeleteRule];
    return [relationships setByAddingObject:categoryRelationship];
}

+ (NSRelationshipDescription *)relationshipWithName:(NSString *)relationshipName
{
    NSRelationshipDescription *relationship =
            [super relationshipWithName:relationshipName];

    if (relationship != nil)
        return relationship;
    if ([relationshipName isEqualToString:kEmergencyNumberCategory]) {
        if (kNumbersRelationship == nil)
            kNumbersRelationship = [[NSRelationshipDescription alloc] init];
        return kNumbersRelationship; 
    }
    return nil;
}

#pragma mark -
#pragma mark EmergencyNumber (Public)

@dynamic name, phone, category;

@end
