//
//  BDACamera.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDACamera.h"
#import "BDALocation.h"


NSString *const kBDACameraSpeed = @"speed";
NSString *const kBDACameraName = @"name";
NSString *const kBDACameraLocation = @"location";
NSString *const kBDACameraType = @"type";


@interface BDACamera ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDACamera

@synthesize speed = _speed;
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
            self.speed = [[self objectOrNilForKey:kBDACameraSpeed fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kBDACameraName fromDictionary:dict];
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDACameraLocation]];
            self.type = [[self objectOrNilForKey:kBDACameraType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kBDACameraSpeed];
    [mutableDict setValue:self.name forKey:kBDACameraName];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDACameraLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDACameraType];

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

    self.speed = [aDecoder decodeDoubleForKey:kBDACameraSpeed];
    self.name = [aDecoder decodeObjectForKey:kBDACameraName];
    self.location = [aDecoder decodeObjectForKey:kBDACameraLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDACameraType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kBDACameraSpeed];
    [aCoder encodeObject:_name forKey:kBDACameraName];
    [aCoder encodeObject:_location forKey:kBDACameraLocation];
    [aCoder encodeDouble:_type forKey:kBDACameraType];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDACamera *copy = [[BDACamera alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.name = [self.name copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
