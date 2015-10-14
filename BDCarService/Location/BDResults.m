//
//  BDResults.m
//
//  Created by hu  on 15/5/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BDResults.h"
#import "BDLocation.h"


NSString *const kBDResultsLocation = @"location";
NSString *const kBDResultsAddress = @"address";
NSString *const kBDResultsDistance = @"distance";
NSString *const kBDResultsTelephone = @"telephone";
NSString *const kBDResultsType = @"type";
NSString *const kBDResultsName = @"name";
NSString *const kBDResultsZipCode = @"zipCode";


@interface BDResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BDResults

@synthesize location = _location;
@synthesize address = _address;
@synthesize distance = _distance;
@synthesize telephone = _telephone;
@synthesize type = _type;
@synthesize name = _name;
@synthesize zipCode = _zipCode;


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
            self.location = [BDLocation modelObjectWithDictionary:[dict objectForKey:kBDResultsLocation]];
            self.address = [self objectOrNilForKey:kBDResultsAddress fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kBDResultsDistance fromDictionary:dict];
            self.telephone = [self objectOrNilForKey:kBDResultsTelephone fromDictionary:dict];
            self.type = [self objectOrNilForKey:kBDResultsType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kBDResultsName fromDictionary:dict];
            self.zipCode = [self objectOrNilForKey:kBDResultsZipCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kBDResultsLocation];
    [mutableDict setValue:self.address forKey:kBDResultsAddress];
    [mutableDict setValue:self.distance forKey:kBDResultsDistance];
    [mutableDict setValue:self.telephone forKey:kBDResultsTelephone];
    [mutableDict setValue:self.type forKey:kBDResultsType];
    [mutableDict setValue:self.name forKey:kBDResultsName];
    [mutableDict setValue:self.zipCode forKey:kBDResultsZipCode];

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

    self.location = [aDecoder decodeObjectForKey:kBDResultsLocation];
    self.address = [aDecoder decodeObjectForKey:kBDResultsAddress];
    self.distance = [aDecoder decodeObjectForKey:kBDResultsDistance];
    self.telephone = [aDecoder decodeObjectForKey:kBDResultsTelephone];
    self.type = [aDecoder decodeObjectForKey:kBDResultsType];
    self.name = [aDecoder decodeObjectForKey:kBDResultsName];
    self.zipCode = [aDecoder decodeObjectForKey:kBDResultsZipCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_location forKey:kBDResultsLocation];
    [aCoder encodeObject:_address forKey:kBDResultsAddress];
    [aCoder encodeObject:_distance forKey:kBDResultsDistance];
    [aCoder encodeObject:_telephone forKey:kBDResultsTelephone];
    [aCoder encodeObject:_type forKey:kBDResultsType];
    [aCoder encodeObject:_name forKey:kBDResultsName];
    [aCoder encodeObject:_zipCode forKey:kBDResultsZipCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    BDResults *copy = [[BDResults alloc] init];
    
    if (copy) {

        copy.location = [self.location copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.zipCode = [self.zipCode copyWithZone:zone];
    }
    
    return copy;
}


@end
