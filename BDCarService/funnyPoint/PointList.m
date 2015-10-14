//
//  PointList.m
//
//  Created by hu  on 15/5/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PointList.h"
#import "Location.h"
#import "AdditionalInformation.h"


NSString *const kPointListDistrict = @"district";
NSString *const kPointListLocation = @"location";
NSString *const kPointListAddress = @"address";
NSString *const kPointListAdditionalInformation = @"additionalInformation";
NSString *const kPointListType = @"type";
NSString *const kPointListName = @"name";
NSString *const kPointListCityName = @"cityName";


@interface PointList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PointList

@synthesize district = _district;
@synthesize location = _location;
@synthesize address = _address;
@synthesize additionalInformation = _additionalInformation;
@synthesize type = _type;
@synthesize name = _name;
@synthesize cityName = _cityName;


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
            self.district = [self objectOrNilForKey:kPointListDistrict fromDictionary:dict];
            self.location = [Location modelObjectWithDictionary:[dict objectForKey:kPointListLocation]];
            self.address = [self objectOrNilForKey:kPointListAddress fromDictionary:dict];
            self.additionalInformation = [AdditionalInformation modelObjectWithDictionary:[dict objectForKey:kPointListAdditionalInformation]];
            self.type = [self objectOrNilForKey:kPointListType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPointListName fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kPointListCityName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.district forKey:kPointListDistrict];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kPointListLocation];
    [mutableDict setValue:self.address forKey:kPointListAddress];
    [mutableDict setValue:[self.additionalInformation dictionaryRepresentation] forKey:kPointListAdditionalInformation];
    [mutableDict setValue:self.type forKey:kPointListType];
    [mutableDict setValue:self.name forKey:kPointListName];
    [mutableDict setValue:self.cityName forKey:kPointListCityName];

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

    self.district = [aDecoder decodeObjectForKey:kPointListDistrict];
    self.location = [aDecoder decodeObjectForKey:kPointListLocation];
    self.address = [aDecoder decodeObjectForKey:kPointListAddress];
    self.additionalInformation = [aDecoder decodeObjectForKey:kPointListAdditionalInformation];
    self.type = [aDecoder decodeObjectForKey:kPointListType];
    self.name = [aDecoder decodeObjectForKey:kPointListName];
    self.cityName = [aDecoder decodeObjectForKey:kPointListCityName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_district forKey:kPointListDistrict];
    [aCoder encodeObject:_location forKey:kPointListLocation];
    [aCoder encodeObject:_address forKey:kPointListAddress];
    [aCoder encodeObject:_additionalInformation forKey:kPointListAdditionalInformation];
    [aCoder encodeObject:_type forKey:kPointListType];
    [aCoder encodeObject:_name forKey:kPointListName];
    [aCoder encodeObject:_cityName forKey:kPointListCityName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PointList *copy = [[PointList alloc] init];
    
    if (copy) {

        copy.district = [self.district copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.additionalInformation = [self.additionalInformation copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
    }
    
    return copy;
}


@end
