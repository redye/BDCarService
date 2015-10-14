//
//  BDACarPark.m
//
//  Created by hu  on 15/5/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDACarPark.h"
#import "BDALocation.h"


NSString *const kBDACarParkLocation = @"location";
NSString *const kBDACarParkType = @"type";
NSString *const kBDACarParkName = @"name";
NSString *const kBDACarParkAddress = @"address";


@interface BDACarPark ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDACarPark

@synthesize location = _location;
@synthesize type = _type;
@synthesize name = _name;
@synthesize address = _address;


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
            self.location = [BDALocation modelObjectWithDictionary:[dict objectForKey:kBDACarParkLocation]];
            self.type = [[self objectOrNilForKey:kBDACarParkType fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kBDACarParkName fromDictionary:dict];
            self.address = [self objectOrNilForKey:kBDACarParkAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDACarParkLocation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kBDACarParkType];
    [mutableDict setValue:self.name forKey:kBDACarParkName];
    [mutableDict setValue:self.address forKey:kBDACarParkAddress];

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

    self.location = [aDecoder decodeObjectForKey:kBDACarParkLocation];
    self.type = [aDecoder decodeDoubleForKey:kBDACarParkType];
    self.name = [aDecoder decodeObjectForKey:kBDACarParkName];
    self.address = [aDecoder decodeObjectForKey:kBDACarParkAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_location forKey:kBDACarParkLocation];
    [aCoder encodeDouble:_type forKey:kBDACarParkType];
    [aCoder encodeObject:_name forKey:kBDACarParkName];
    [aCoder encodeObject:_address forKey:kBDACarParkAddress];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDACarPark *copy = [[BDACarPark alloc] init];
    
    if (copy) {

        copy.location = [self.location copyWithZone:zone];
        copy.type = self.type;
        copy.name = [self.name copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
    }
    
    return copy;
}


@end
