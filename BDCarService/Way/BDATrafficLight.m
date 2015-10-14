//
//  BDATrafficLight.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDATrafficLight.h"
#import "BDALocation.h"


NSString *const kBDATrafficLightName = @"name";
NSString *const kBDATrafficLightLocation = @"location";
NSString *const kBDATrafficLightType = @"type";


@interface BDATrafficLight ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDATrafficLight

@synthesize name = _name;
@synthesize location = _location;
@synthesize type = _type;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kBDATrafficLightName fromDictionary:dict];
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDATrafficLightLocation]];
            self.type = [[self objectOrNilForKey:kBDATrafficLightType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kBDATrafficLightName];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDATrafficLightLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDATrafficLightType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kBDATrafficLightName];
    self.location = [aDecoder decodeObjectForKey:kBDATrafficLightLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDATrafficLightType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kBDATrafficLightName];
    [aCoder encodeObject:_location forKey:kBDATrafficLightLocation];
    [aCoder encodeDouble:_type forKey:kBDATrafficLightType];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDATrafficLight *copy = [[BDATrafficLight alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
