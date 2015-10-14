//
//  BDAEntrance.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDAEntrance.h"
#import "BDALocation.h"


NSString *const kBDAEntranceLocation = @"location";
NSString *const kBDAEntranceType = @"type";
NSString *const kBDAEntranceName = @"name";
NSString *const kBDAEntranceDirection = @"direction";


@interface BDAEntrance ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDAEntrance

@synthesize location = _location;
@synthesize type = _type;
@synthesize name = _name;
@synthesize direction = _direction;


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
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDAEntranceLocation]];
            self.type = [[self objectOrNilForKey:kBDAEntranceType fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kBDAEntranceName fromDictionary:dict];
            self.direction = [self objectOrNilForKey:kBDAEntranceDirection fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDAEntranceLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDAEntranceType];
    [mutableDict setValue:self.name forKey:kBDAEntranceName];
    [mutableDict setValue:self.direction forKey:kBDAEntranceDirection];

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

    self.location = [aDecoder decodeObjectForKey:kBDAEntranceLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDAEntranceType];
    self.name = [aDecoder decodeObjectForKey:kBDAEntranceName];
    self.direction = [aDecoder decodeObjectForKey:kBDAEntranceDirection];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_location forKey:kBDAEntranceLocation];
    [aCoder encodeDouble:_type forKey:kBDAEntranceType];
    [aCoder encodeObject:_name forKey:kBDAEntranceName];
    [aCoder encodeObject:_direction forKey:kBDAEntranceDirection];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDAEntrance *copy = [[BDAEntrance alloc] init];
    
    if (copy) {

        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
        copy.name = [self.name copyWithZone:zone];
        copy.direction = [self.direction copyWithZone:zone];
    }
    
    return copy;
}


@end
